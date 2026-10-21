from starlette.applications import Starlette
from starlette.responses import HTMLResponse
from starlette.routing import Mount, Route
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates
import os
import psycopg
from consult import get_penalty
from datetime import datetime
from zoneinfo import ZoneInfo
import locale

locale.setlocale(locale.LC_TIME, 'pt_BR.UTF-8')
fuso_sp = ZoneInfo("America/Sao_Paulo")

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

  if len(crimes["PLAYER_ID"]) > 20:
    raise ValueError("PLAYER_ID cannot exceed 20 characters.")

  if (crimes["COPS_KILLED"] > 10 or
      crimes["VEHICLES_STOLEN"] > 10 or
      crimes["STORE_HOLD_UPS"] > 10 or
      crimes["MURDERED_CIVILIANS"] > 10):
    raise ValueError("Crime values cannot exceed 10.")

  set_crimes(crimes)
  result_us, result_br = get_penalty(crimes["PLAYER_ID"].lower())
  crimes_bloco_1 = result_us[:-1] # Todos menos o último (que é a sentença final)
  sentenca_final_1 = result_us[-1]['anos_pena'] # O último item

  crimes_bloco_2 = result_br[:-1]
  sentenca_final_2 = result_br[-1]['anos_pena']

  nome_player = result_us[0]['player_id']
  data_sentenca = datetime.now(tz=fuso_sp).strftime("%d de %B de %Y.")

  contexto = {
    "nome_player": nome_player,
    "data_sentenca": data_sentenca,
    "crimes_bloco_1": crimes_bloco_1,
    "sentenca_final_1": sentenca_final_1,
    "crimes_bloco_2": crimes_bloco_2,
    "sentenca_final_2": sentenca_final_2
  }
  
  return templates.TemplateResponse(request, "penalty.html", contexto)

routes = [
    Route("/", endpoint=homepage, name="homepage"),
    Route("/crimes", endpoint=save_stats, methods=["POST"], name="save_stats"),
    Mount("/static", app=StaticFiles(directory="static"), name="static"),
]

app = Starlette(debug=True, routes=routes)