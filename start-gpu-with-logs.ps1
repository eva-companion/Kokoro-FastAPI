$env:PHONEMIZER_ESPEAK_LIBRARY="C:\Program Files\eSpeak NG\libespeak-ng.dll"
$env:PYTHONUTF8=1
$Env:PROJECT_ROOT="$pwd"
$Env:USE_GPU="true"
$Env:USE_ONNX="false"
$Env:PYTHONPATH="$Env:PROJECT_ROOT;$Env:PROJECT_ROOT/api"
$Env:MODEL_DIR="src/models"
$Env:VOICES_DIR="src/voices/v1_0"
$Env:WEB_PLAYER_PATH="$Env:PROJECT_ROOT/web"

# Create logs directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "logs" | Out-Null

# Start uvicorn with logging to file
Write-Host "Starting Kokoro TTS server on port 8880..."
Write-Host "Logs will be written to: logs/kokoro-tts.log"
Write-Host "Press Ctrl+C to stop the server"
Write-Host ""

uv run --no-sync uvicorn api.src.main:app --host 0.0.0.0 --port 8880 --log-level debug 2>&1 | Tee-Object -FilePath "logs/kokoro-tts.log"
