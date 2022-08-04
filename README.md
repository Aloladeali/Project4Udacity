[![CircleCI](https://dl.circleci.com/status-badge/img/gh/Aloladeali/Project4Udacity/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Aloladeali/Project4Udacity/tree/master)
## Project Summary

In this project I applied  the skills I acquired in this course to operationalize a Machine Learning Microservice API.

This entire project was built, tested and run using AWS Cloud9, Docker, Hadolint, Github and CircleCI.

The application was containerized using the Dockerfile, after which it was deployed to Docker and was used to make predictions. As instructed, and exta log statement was added to the app.py file.

Kubernetes was used to deploy a container, and predictons were made.

Finally, all changes were pushed to Github and connected to CircleCI.


## Steps involved in the Project
AWS Cloud9 already has python3 and Docker installed.

* Create a virtualenv with Python 3.7 and activate it within the project directory. 
```bash
python3 -m venv ~/.devops
source ~/.devops/bin/activate
```
* Run `make install` to install the necessary dependencies

* To install Hadolint. 
```bash
sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
sudo chmod +x /bin/hadolint
```

* To install minikube. 
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
* To install kubectl. 
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

* To complete run_docker.sh. 
```bash
docker build --tag=projectfour .

docker images list

docker run -p 8000:80 projectfour
```


* To complete Dockerfile. 
```bash
FROM python:3.7.3-stretch
WORKDIR /app

COPY . app.py /app

RUN pip install --upgrade pip &&\
    pip install -r requirements.
    
EXPOSE 80

CMD ["python", "app.py"]
```
* To add exta log info to app.py. 
```bash
# TO DO:  Log the output prediction value
    LOG.info(f"output of prediction: {prediction}")
    return jsonify({'prediction': prediction})
```

* To upload docker image via upload_docker.sh. 
```bash

dockerpath="alolade/projectfour:v1.0.0"

docker login
docker tag projectfour $dockerpath
echo "Docker ID and Image: $dockerpath"

docker push $dockerpath
```

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`
4. Make Prediction:  `./make_prediction.sh`
5. Upload Docker: `./upload_docker.sh`
6. Delete cluster: `minikube delete`

### Kubernetes Steps

* Setup and Configure Kubernetes locally: `minikube start``
* Run via kubectl( in run_kubernetes.sh)
```bash
kubectl run projectfour --image=alolade/projectfour:v1.0.0 --port=80 --labels app=projectfour

kubectl get pods

kubectl port-forward projectfour 8000:80

```
## Description of files in the Repository
Kubernetes_out.txt: This clontains the prediction output run via Kubernetes deployment. it includes the pod’s name and status, as well as the port forwarding and handling text.

Docker_out.txt: This contains the prediction output when the app is run via Docker deployment. It includes all log statements plus a line that reads POST /predict HTTP/1.1” 200 - The 200 is a standard value indicating the good “health” of an interaction. 
It also shows the extra log information added to the app.py file.

Dockerfile: This contains instructions to containerize the app using docker.

make_prediction.sh: contains the shell script used to make predictions.

upload_docker.sh: contains the shell script used to upload the docker image.

run_docker.sh: contains the shell script used to run and build the Docker image.

run_kubernetes.sh: contains the shell script used to deploy the application using kubectl.

requirements.txt: contains required project dependencies.

Makefile: contains instructions to install the dependencies.

.circleci/config.yml: the configuratin file used to run the build in CircleCI.