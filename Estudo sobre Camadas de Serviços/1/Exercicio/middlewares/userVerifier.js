const emptyVerification = (req, res, next) => {
  const {firstName, lastName, email, password} = req.body;
  if (!(firstName && lastName && email && password)) {
    return res
        .status(401)
        .json({message: 'Verifique se algum dos campos não está vazio'});
  }
  next();
};

const passwordVerification = (req, res, next) => {
  const {password} = req.body;
  // Eu não irei fazer as outras verificações por motivos de "sem tempo irmão"
  if (typeof password !== 'string' || password.length < 6) {
    res.status(401).json({
      'error': true,
      'message': 'O campo \'password\' deve ter pelo menos 6 caracteres',
    });
  }
  next();
};

module.exports = {
  emptyVerification,
  passwordVerification,
};
