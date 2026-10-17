from starlette.applications import Starlette
from starlette.responses import HTMLResponse
from starlette.routing import Mount, Route
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates

# Configura o diretório de templates Jinja2
templates = Jinja2Templates(directory="templates")

# Rota Principal
async def homepage(request):
  contexto = {"request": request, "site_nome": "Starlette App"}
  return templates.TemplateResponse(request, "index.html", contexto)

routes = [
    Route("/", endpoint=homepage, name="homepage"),
    Mount("/static", app=StaticFiles(directory="static"), name="static"),
    Mount("/static", app=StaticFiles(directory="static"), name="static"),
]

app = Starlette(debug=True, routes=routes)