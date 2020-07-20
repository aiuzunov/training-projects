const jwt = require('jsonwebtoken');
const config = require("./config");

const getToken = (user) => {
    return jwt.sign({user},config.JWT_SECRET, {
        expiresIn: '48h'
    })
};

const Authenticated = (req,res,next) => {
    const token = req.headers.authorization;
    if(token){
        const onlyToken = token.slice(7,token.length);
        jwt.verify(onlyToken,config.JWT_SECRET,(err,decode) =>{
            if(err){
                return res.status(401).send({msg:'Invalid token'});
            }
            req.user = token
            next();
            return
        })
    }
    return res.status(401).send({msg:'Token is not supplied'})
}

const Employee = (req,res,next) => {
    if(req.user && req.user.isEmployee) {
        return next();
    }
    return res.status(401).send({msg:'Admin Token is Not Valid'})
}


module.exports = getToken,Authenticated,Employee;
