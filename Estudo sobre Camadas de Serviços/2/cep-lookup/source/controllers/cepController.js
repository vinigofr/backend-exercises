// Comumente, são nos controllers que ficam os famigerados middlewares.
// Serão eles os responsáveis acessar a CAMADA DE SERVIÇO e esperar por seu retorno.

const CepService = require('../services/cepServices');

const getByCep = async (req, res) => {
  const { cep } = req.params;
  try {
    const data = await CepService.getByCep(cep);
    res.status(200).json(data);
  } catch (e) {
    res.status(500).json({ message: 'Bad request'});
  }
}

module.exports = {
  getByCep,
}
