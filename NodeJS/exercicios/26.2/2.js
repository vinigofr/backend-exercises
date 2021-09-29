const {three} = require('./1');

const sendRandomNumbers = () => {
  const random = [];
  random.length = 0;

  for(i = 0; i < 3; i++) {
    random.push(Math.floor(Math.random() * 100 + 1));
  };

  three(random[0], random[1], random[2])
  .then((content) => console.log(content))
  .catch((e) => console.log(e.message));

}

sendRandomNumbers();
