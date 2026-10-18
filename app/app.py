from starlette.applications import Starlette
from starlette.responses import HTMLResponse
from starlette.routing import Mount, Route
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates
import os
import psycopg

templates = Jinja2Templates(directory="templates")

async def homepage(request):
  contexto = {"request": request, "site_nome": "Starlette App"}
  return templates.TemplateResponse(request, "index.html", contexto)

def set_crimes(crimes):
  query = """
    INSERT INTO PUBLIC.GTA (PLAYER_ID, COPS_KILLED, VEHICLES_STOLEN, STORE_HOLD_UPS, MURDERED_CIVILIANS) 
    VALUES (%s, %s, %s, %s, %s)
    ON CONFLICT (PLAYER_ID) 
    DO UPDATE SET 
        COPS_KILLED = EXCLUDED.COPS_KILLED,
        VEHICLES_STOLEN = EXCLUDED.VEHICLES_STOLEN,
        STORE_HOLD_UPS = EXCLUDED.STORE_HOLD_UPS,
        MURDERED_CIVILIANS = EXCLUDED.MURDERED_CIVILIANS;
  """
  with psycopg.connect(os.environ["DATABASE_URL"]) as conn:
    with conn.cursor() as cur:
        cur.execute(
            query,
            (crimes["PLAYER_ID"].lower(), crimes["COPS_KILLED"], crimes["VEHICLES_STOLEN"], crimes["STORE_HOLD_UPS"], crimes["MURDERED_CIVILIANS"])
        )

async def save_stats(request):
  form_data = await request.form()
  crimes = {
    "PLAYER_ID": form_data.get("PLAYER_ID"),
    "COPS_KILLED": int(form_data.get("COPS_KILLED") or 0),
    "VEHICLES_STOLEN": int(form_data.get("VEHICLES_STOLEN") or 0),
    "STORE_HOLD_UPS": int(form_data.get("STORE_HOLD_UPS") or 0),
    "MURDERED_CIVILIANS": int(form_data.get("MURDERED_CIVILIANS") or 0)
  }

  set_crimes(crimes)

  contexto = {}
  return templates.TemplateResponse(request, "penalty.html", contexto)

routes = [
    Route("/", endpoint=homepage, name="homepage"),
    Route("/crimes", endpoint=save_stats, methods=["POST"], name="save_stats"),
    Mount("/static", app=StaticFiles(directory="static"), name="static"),
]

app = Starlette(debug=True, routes=routes)