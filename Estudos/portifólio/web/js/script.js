feather.replace()

const nextEl = document.getElementById('next');
const previsousEl = document.getElementById('previous');
const sliderEl = document.getElementById('slider');
nextEl.addEventListener('click', onNextclick);
previsousEl.addEventListener('click', onPreviousClick);

function onNextclick() {
  const imgWidth = sliderEl.offsetWidth;
  sliderEl.scrollLeft+=imgWidth;
}

function onPreviousClick(){
const imgWidth = sliderEl.offsetWidth;
sliderEl.scrollLeft -= imgWidth;
}