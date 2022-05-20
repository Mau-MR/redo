const express = require('express');
const router = express.Router()
const {connection} = require("../config/mysql.js")
const path = '/justification'


//create a justification
router.post(path,(req,res) =>{
    const { date,idBeneficiary,idReason } = req.body
    connection.query("CALL `REDO_MAKMA`.`createJustification`(?,?,?);",
    [date, idBeneficiary, idReason],(err, result, fields) =>{
        if(err){
            console.log(err)
            res.status(500).send({
                done:false
            })
        }
        else{
            res.json({done:true});
        }
    })
})

module.exports = router;