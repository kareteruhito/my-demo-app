"use strict";

const raw = document.getElementById("slides-data").textContent;
const slides = JSON.parse(raw);

let timerId = null;
let index = -1;
let started = false;

const img = document.getElementById("img");
const video = document.getElementById("video");
const text = document.getElementById("text");

const bgmChannels = [
  document.getElementById("bgm0"),
  document.getElementById("bgm1"),
  document.getElementById("bgm2")
];
const voiceAudio = document.getElementById("voice"); // セリフ音声用

function initScreen() {
  text.textContent = "クリックで開始";
}

// 共通の「次へ」関数
function nextSlide() {
  index++;
  showSlide(index);
}

initScreen();

function showSlide(i) {
  const s = slides[i];

  // 前の状態をクリア
  clearTimeout(timerId);
  video.onended = null;

  if (!s) {
    text.textContent = "おわり";
    img.style.display = "none";
    video.style.display = "none";
    voiceAudio.pause();
    bgmAudio.pause();
    return;
  }

  // --------------------------------------------------
  // BGM 開始スライド
  // --------------------------------------------------
  if (s.type === "bgm") {
      const ch = s.channel ?? 0;   // 指定がなければ0番
      const audio = bgmChannels[ch];

      audio.src = s.src;
      audio.loop = true;
      audio.volume = s.volume ?? 1.0;
      audio.play().catch(() => console.warn("BGM 再生失敗"));

      nextSlide();
      return;
  }

  // --------------------------------------------------
  // BGM 停止スライド
  // --------------------------------------------------
  if (s.type === "bgmStop") {
      const ch = s.channel ?? 0;
      const audio = bgmChannels[ch];
      audio.pause();
      audio.currentTime = 0;

      nextSlide();
      return;
  }

  // --------------------------------------------------
  // 背景：image
  // --------------------------------------------------
  if (s.type === "image") {
    if (s.src) {
      img.src = s.src;
    }
    img.style.display = "block";

    video.pause();
    video.style.display = "none";

    text.textContent = "";
    voiceAudio.pause();

    // 自動で次へ進めたい場合
    if (s.autoNext) {
      const wait = typeof s.wait === "number" ? s.wait : 500;
      timerId = setTimeout(nextSlide, wait);
    }
    return;
  }

  // --------------------------------------------------
  // 背景：video
  // --------------------------------------------------
  if (s.type === "video") {
    if (s.src) {
      video.src = s.src;
    }
    video.loop = s.loop ?? false;
    video.style.display = "block";
    img.style.display = "none";

    text.textContent = "";
    voiceAudio.pause();

    if (s.autoPlay) {
      video.play().catch(() => {
        console.warn("動画の自動再生に失敗しました");
      });
    }

    if (s.autoNext) {
      // 背景アニメとしてすぐ次へ
      nextSlide();
    } else {
      // 終了したら次へ
      video.onended = () => nextSlide();
    }
    return;
  }

  // --------------------------------------------------
  // セリフ：voice
  // --------------------------------------------------
  if (s.type === "voice") {
    text.textContent = s.text ?? "";

    if (s.voice) {
      voiceAudio.src = s.voice;
      voiceAudio.play().catch(() => {
        console.warn("voice 再生に失敗しました");
      });
    } else {
      voiceAudio.pause();
    }

    // voice スライドはここで止まる（クリック待ち）
    return;
  }

  // 想定外 type
  console.warn("Unknown slide type:", s.type);
}

// クリック → voice スライドのときだけ次へ
document.body.addEventListener("click", () => {
  if (!started) {
    // ★ 初回クリックでゲーム開始
    started = true;
    nextSlide();   // index が -1 → 0 になってスライド0からスタート
    return;
  }
  const s = slides[index];
  if (!s) return;

  if (s.type === "voice") {
    nextSlide();
  }
});
