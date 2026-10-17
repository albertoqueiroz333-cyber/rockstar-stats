from starlette.applications import Starlette
from starlette.responses import HTMLResponse
from starlette.routing import Mount, Route
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates
import os
import psycopg


# Configura o diretório de templates Jinja2
templates = Jinja2Templates(directory="templates")

# Rota Principal
async def homepage(request):
  contexto = {"request": request, "site_nome": "Starlette App"}
  return templates.TemplateResponse(request, "index.html", contexto)

def get_crime_penalty(crimes):
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
  # Aqui você pode adicionar a lógica para calcular a pena com base nos crimes cometidos
  # Por exemplo, você pode definir regras de penalidade para cada tipo de crime
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
  # Aqui você pode adicionar a lógica para salvar os dados no banco de dados ou realizar outros processos
  # Por exemplo, você pode inserir os dados na tabela "crimes" do banco de dados
  get_crime_penalty(crimes)
  # Aqui você pode adicionar a lógica para exibir a pena calculada ao usuário
  # Por exemplo, você pode passar a pena para o template HTML e exibi-la
  contexto = {}
  return templates.TemplateResponse(request, "penalty.html", contexto)

routes = [
    Route("/", endpoint=homepage, name="homepage"),
    Route("/crimes", endpoint=save_stats, methods=["POST"], name="save_stats"),
]

app = Starlette(debug=True, routes=routes)