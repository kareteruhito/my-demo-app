Add-Type -AssemblyName System.Speech

# 音声ファイル作成スクリプト

$voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
$voices = $voice.GetInstalledVoices() | ForEach-Object { $_.VoiceInfo.Name }
$voiceName = $voices[0]
Write-Host $voiceName

$voice.SelectVoice($voiceName)

$voice.SetOutputToWaveFile("voice001.wav")
$voice.Speak("目を覚ますと、そこは森の中だった。")
$voice.SetOutputToDefaultAudioDevice()

Remove-Item "voices\v001.mp3" -ErrorAction SilentlyContinue
ffmpeg.exe -i voice001.wav voices\v001.mp3
Remove-Item voice001.wav

$voice.SetOutputToWaveFile("voice002.wav")
$voice.Speak("草むらの向こうから、何かが動いている気配がした。")
$voice.SetOutputToDefaultAudioDevice()

Remove-Item "voices\v002.mp3" -ErrorAction SilentlyContinue
ffmpeg.exe -i voice002.wav voices\v002.mp3
Remove-Item voice002.wav

$voice.SetOutputToWaveFile("voice003.wav")
$voice.Speak("僕は思わず、その場に立ち尽くした。")
$voice.SetOutputToDefaultAudioDevice()

Remove-Item "voices\v003.mp3" -ErrorAction SilentlyContinue
ffmpeg.exe -i voice003.wav voices\v003.mp3
Remove-Item voice003.wav

