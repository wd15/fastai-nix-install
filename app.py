from starlette.applications import Starlette
from starlette.responses import JSONResponse, HTMLResponse
import uvicorn
import aiohttp
import asyncio
from fastai.vision import open_image
from io import BytesIO


app = Starlette()


#@app.route('/')
#async def homepage(request):
#    return JSONResponse({'hello': 'world'})

async def get_bytes(url):
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.read()
                    
    
def predict_image_from_bytes(bytes):
    img = open_image(BytesIO(bytes))
    print(type(img))
    return JSONResponse({"something":"blah"})
    #losses = img.predict(cat_learner)
    #return JSONResponse({
    #    "predictions": sorted(
    #        zip(cat_learner.data.classes, map(float, losses)),
    #        key=lambda p: p[1],
    #        reverse=True
    #    )
    #})
            
    
@app.route("/classify-url", methods=["GET"])
async def classify_url(request):
    bytes = await get_bytes(request.query_params["url"])
    return predict_image_from_bytes(bytes)

    
@app.route("/")
def form(request):
    return HTMLResponse(
        """
        <form action="/upload" method="post" enctype="multipart/form-data">
            Select image to upload:
            <input type="file" name="file">
            <input type="submit" value="Upload Image">
        </form>
        Or submit a URL:
        <form action="/classify-url" method="get">
            <input type="url" name="url">
            <input type="submit" value="Fetch and analyze image">
        </form>
    """)
    
@app.route("/classify-url", methods=["GET"])
async def classify_url(request):
    bytes = await get_bytes(request.query_params["url"])
    img = open_image(BytesIO(bytes))
    _,_,losses = learner.predict(img)
    return JSONResponse({
        "predictions": sorted(
            zip(cat_learner.data.classes, map(float, losses)),
            key=lambda p: p[1],
            reverse=True
        )
    })

if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=5000)
