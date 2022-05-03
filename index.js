const express = require('express')
const cors = require('cors');
const app = express();
const users = require('./routes/users')
const status = require('./routes/status')
const branch = require('./routes/branch')
const userRole = require('./routes/userRole')
const user = require('./routes/user')
const beneficiaries = require('./routes/beneficiaries')
const beneficiary = require('./routes/beneficiary')
const {authMiddleware, login} = require('./routes/authorization.js')
const {auth} = require("mysql/lib/protocol/Auth");
app.use(cors())
app.use(express.urlencoded({ extended: true })); //Nos permite tomar el contenido del cuerpo
app.use(express.json());  //Para pasarlo a formato json

//Routes
const path = '/api'
app.post(path+"/login", login)
app.use(authMiddleware)
//IMPORTANT: ALL THE ROUTES THAT ARE ADDED UP FROM THE AUTHMIDDLEWARE WILL BE UNPROTECTED
// ADD ALL THE PROTECTED ROUTES BELOW THIS COMMENT
app.use(path, users);
app.use(path,status);
app.use(path,branch);
app.use(path,userRole);
app.use(path,user);
app.use(path,beneficiaries);
app.use(path,beneficiary);

//Servidor
app.set('port', process.env.PORT || 8080)
app.listen(app.get('port'), () => {
    //TODO: PRINT THE CORRECT PORT AND ADDRESS OF THE SERVER
    console.log("Servidor iniciado correctamente");
});