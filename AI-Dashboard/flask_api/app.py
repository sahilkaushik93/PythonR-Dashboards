from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
import joblib
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

app = Flask(__name__)

# Load & train model on request
@app.route('/train', methods=['POST'])
def train_model():
    file = request.files['file']
    df = pd.read_csv(file)

    # Assume last column is the target
    X = df.iloc[:, :-1]
    y = df.iloc[:, -1]

    # Preprocessing
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # Train model
    model = LogisticRegression()
    model.fit(X_scaled, y)

    # Save model
    joblib.dump(model, 'model.pkl')
    joblib.dump(scaler, 'scaler.pkl')

    return jsonify({"message": "Model trained successfully!"})

# Predict on new data
@app.route('/predict', methods=['POST'])
def predict():
    file = request.files['file']
    df = pd.read_csv(file)

    model = joblib.load('model.pkl')
    scaler = joblib.load('scaler.pkl')

    X_scaled = scaler.transform(df)
    predictions = model.predict(X_scaled)

    return jsonify({"predictions": predictions.tolist()})

if __name__ == '__main__':
    app.run(port=5000, debug=True)
