import uvicorn
import firebase_admin
import pyrebase
import json

from firebase_admin import credentials, auth
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.exceptions import HTTPException

"""
to run copy to the terminal --> uvicorn --port 9000 main:app --reload

"""




"""
set up FastAPI and our Firebase connection,
will be using uvicorn to create our server,
firebase_admin and pyrebase connect to Firebase and use its authentication service, 
json to read JSON objects, and finally FastAPI to build our API endpoints
"""

cred = credentials.Certificate('sublet.json')
firebase = firebase_admin.initialize_app(cred)
config = json.load(open('firebase_config.json'))
api_key = config['client'][0]['api_key'][0]['current_key']
try:
    auth_domain = config["authDomain"]
except KeyError:
    auth_domain = "your-auth-domain.firebaseapp.com"
try:
    database_url = config["databaseURL"]
except KeyError:
    database_url = "https://your-project-id.firebaseio.com"
pb = pyrebase.initialize_app({
    "apiKey": api_key,
    "authDomain": auth_domain,
    "databaseURL": database_url,
    "projectId": config["project_info"]["project_id"],
    "storageBucket": config["project_info"]["storage_bucket"]
})
app = FastAPI()

"""
add middleware to our app that allows cross origin resource sharing (CORS).
 We’ll set it up so that we can hit our API from anywhere. 
"""
allow_all = ['*']
app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_all,
    allow_credentials=True,
    allow_methods=allow_all,
    allow_headers=allow_all
)

"""FastAPI uses async functionality, so we will be creating an asynchronous function. \
The only parameter that we need to pass our function is the HTTP request being sent"""


# signup endpoint
@app.post("/signup", include_in_schema=False)
async def signup(request: Request):
    req = await request.json()
    email = req['email']
    password = req['password']
    if email is None or password is None:
        return HTTPException(detail={'message': 'Error! Missing Email or Password'}, status_code=400)
    try:
        user = auth.create_user(
            email=email,
            password=password
        )
        return JSONResponse(content={'message': f'Successfully created user {user.uid}'}, status_code=200)
    except:
        return HTTPException(detail={'message': 'Error Creating User'}, status_code=400)


# login endpoint
@app.post("/login", include_in_schema=False)
async def login(request: Request):
    # extract the email and password from the JSON and try to authenticate
    # the user using the pyrebase instance we created earlier.
    req_json = await request.json()
    email = req_json['email']
    password = req_json['password']
    try:
        user = pb.auth().sign_in_with_email_and_password(email, password)
        jwt = user['idToken']
        return JSONResponse(content={'token': jwt}, status_code=200)
    except:
        return HTTPException(detail={'message': 'There was an error logging in'}, status_code=400)


"""
This code is creating an endpoint in a FastAPI web application that validates a JSON web token (JWT).
 When a request is sent to this endpoint (a POST request to the '/ping' URL), the function will retrieve 
 the JWT from the request headers and print it to the console.
  It will then use the verify_id_token method from the Firebase Admin auth module to verify the JWT and 
  return the user ID associated with the token. 
  If the token cannot be verified, an error will be thrown and handled by the server.
 This endpoint can be used to validate the authenticity of a JWT and ensure that it has been issued by a trusted source.
"""
# ping endpoint
@app.post("/ping", include_in_schema=False)
async def validate(request: Request):
    headers = request.headers
    jwt = headers.get('authorization')
    print(f"jwt:{jwt}")
    user = auth.verify_id_token(jwt)
    return user["uid"]


if __name__ == "__main__":
    uvicorn.run("main:app")

"""cerdit @https://pythonalgos.com/python-firebase-authentication-integration-with-fastapi/#ping-endpoint-firebase-admin"""
