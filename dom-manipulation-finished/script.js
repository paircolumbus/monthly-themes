var red = document.getElementsByName('red')[0];
var blue = document.getElementsByName('blue')[0];
var white = document.getElementsByName('white')[0];

  red.addEventListener('click', function(){
    var color = this.getAttribute('data-color');
    console.log("color is " + color);
    document.body.style.backgroundColor = color;
  });

  blue.addEventListener('click', function(){
    var color = this.getAttribute('data-color');
    console.log("color is " + color);
    document.body.style.backgroundColor = color;
  });

  white.addEventListener('click', function(){
    var color = this.getAttribute('data-color');
    console.log("color is " + color);
    document.body.style.backgroundColor = color;
  });
