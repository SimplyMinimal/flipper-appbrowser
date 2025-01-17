FROM nikolaik/python-nodejs:latest

# Install nodejs cli utils
RUN npm install -g nodemon concurrently

# Install ufbt
RUN apt update && apt install git
RUN git clone https://github.com/flipperdevices/flipperzero-ufbt /opt/ufbt
RUN /opt/ufbt/ufbt update

# Install backend
ADD backend /app/backend
WORKDIR /app/backend
RUN pip install -r requirements.txt

# Install frontend
ADD frontend /app/frontend
WORKDIR /app/frontend
RUN npm i

WORKDIR /app
ENTRYPOINT [ "concurrently", "cd /app/backend && nodemon index.py", "cd /app/frontend && npm run watch" ]