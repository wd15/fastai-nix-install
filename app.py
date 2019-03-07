from starlette.applications import Starlette
from starlette.responses import JSONResponse, HTMLResponse
import uvicorn
import aiohttp
import asyncio
from fastai.vision import open_image, load_learner, defaults, torch, Path
from io import BytesIO


defaults.device = torch.device('cpu')

app = Starlette()


async def get_bytes(url):
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()
                    
    
def predict_image_from_bytes(bytes):
    img = open_image(BytesIO(bytes))
    learn = load_learner(Path('data/plants'))
    pred_class, _, _ = learn.predict(img)
    return JSONResponse({"prediction": pred_class.obj})
            
    
@app.route("/classify-url", methods=["GET"])
async def classify_url(request):
    bytes = await get_bytes(request.query_params["url"])
    return predict_image_from_bytes(bytes)

    
@app.route("/")
def form(request):
    return HTMLResponse(
        """
        Submit an image of either an Aloe, an Anthurium or an Arrowhead plant for classification.
        <form action="/classify-url" method="get">
            <input type="url" name="url">
            <input type="submit" value="Fetch and analyze image">
        </form>
    """)
    

if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=5000)
