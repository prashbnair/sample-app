from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World'

if __name__ == '__main__':
    cert_file = os.getenv("TLS_CERT_FILE")
    key_file = os.getenv("TLS_KEY_FILE")
    ssl_context = (cert_file, key_file) if cert_file and key_file else "adhoc"

    app.run(host = '0.0.0.0', ssl_context=ssl_context)