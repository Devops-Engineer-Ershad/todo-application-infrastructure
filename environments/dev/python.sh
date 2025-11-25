sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.8 python3.8-venv python3.8-dev

git clone https://github.com/devopsengineer-ershad/PyTodoBackEndMonoLith.git
cd PyTodoBackEndMonoLith

sudo su
apt-get update && apt-get install -y curl gnupg2 unixodbc unixodbc-dev

curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
    > /etc/apt/sources.list.d/mssql-release.list

apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18
python3 -m pip install --upgrade --ignore-installed PyYAML
python3 -m pip install -r requirements.txt

uvicorn app:app --host 0.0.0.0 --port 8000
