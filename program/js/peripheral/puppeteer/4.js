const axios = require('axios');
const useAxios = () => {
  axios.get('https://www.guazi.com/hz/buy/')
    .then(((result) => {
      console.log(result.data);
    }))
    .catch((err) => {
      console.log(err);
    });
};