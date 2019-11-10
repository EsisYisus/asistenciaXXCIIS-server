const mysql = require('mysql');

const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'asistenciaxxciis'
});

let aciisdb = {};

aciisdb.all = () => {
    return new Promise((resolve, reject) => {
        pool.query('SELECT * FROM usuarios', (err, res) =>{
            if(err) {
                return reject(err);
            }
            return resolve(res);
        });
    });
};

aciisdb.all = (dni) => {
    console.log(dni);
    return new Promise((resolve, reject) => {
        pool.query('SELECT * FROM usuarios WHERE dni=?', [dni], (err, res) => {
            (err) ? reject(err) : resolve(res[0]);
        });
    });

}

module.exports = aciisdb;
