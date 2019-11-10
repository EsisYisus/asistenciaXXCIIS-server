const express = require('express');
const router = express.Router();

const mysqlConnection = require('./database');

router.get('/', (req, res) => {
    mysqlConnection.query('SELECT * FROM usuarios', (err, rows, fields) => {
        if(!err){
            res.json(rows);
        }else{
            console.log(err);
        }
    });
});

router.get('/:id', (req, res) => {
    const {id} = req.params;
    mysqlConnection.query('SELECT * FROM usuarios WHERE dni = ?', [id], (err, rows, fields) => {
        if(!err){
            res.json(rows[0]);
        }else{
            console.log(err);
        }
    });
});

router.post('/', (req, res) => {
    const {dni} = req.body;

    mysqlConnection.query('SELECT pruebafuncion(?) AS nombres', [dni], (err, results, fields)=> {
        if(!err){
            // res.json({Status: 'suma correcta'});
            res.json(results[0]);
        }else{
            console.log(err);
        }
    });
})

module.exports = router;