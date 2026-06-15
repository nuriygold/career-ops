const slides = Array.from(document.querySelectorAll('[data-slide]'));
const currentSlide = document.getElementById('current-slide');
const totalSlides = document.getElementById('total-slides');
const prevButton = document.getElementById('prev');
const nextButton = document.getElementById('next');

let index = 0;
totalSlides.textContent = String(slides.length);

function render() {
  slides.forEach((slide, slideIndex) => {
    slide.classList.toggle('is-active', slideIndex === index);
  });
  currentSlide.textContent = String(index + 1);
  prevButton.disabled = index === 0;
  nextButton.disabled = index === slides.length - 1;
  window.location.hash = `slide-${index + 1}`;
}

function goTo(nextIndex) {
  if (nextIndex < 0 || nextIndex >= slides.length) {
    return;
  }
  index = nextIndex;
  render();
}

prevButton.addEventListener('click', () => goTo(index - 1));
nextButton.addEventListener('click', () => goTo(index + 1));

document.addEventListener('keydown', (event) => {
  if (event.key === 'ArrowRight' || event.key === 'PageDown' || event.key === ' ') {
    event.preventDefault();
    goTo(index + 1);
  }
  if (event.key === 'ArrowLeft' || event.key === 'PageUp') {
    event.preventDefault();
    goTo(index - 1);
  }
  if (event.key === 'Home') {
    event.preventDefault();
    goTo(0);
  }
  if (event.key === 'End') {
    event.preventDefault();
    goTo(slides.length - 1);
  }
});

const hashMatch = window.location.hash.match(/slide-(\d+)/);
if (hashMatch) {
  const initialIndex = Number(hashMatch[1]) - 1;
  if (!Number.isNaN(initialIndex)) {
    index = Math.max(0, Math.min(slides.length - 1, initialIndex));
  }
}

render();
