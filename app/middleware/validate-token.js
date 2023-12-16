// import jwt from 'jsonwebtoken';

// export const validateToken = (req, res, next) => {
//     const authHeader = req.headers['authorization'];
//     const token = authHeader && authHeader.split(' ')[1];

//     if (token == null) {
//         return res.status(401).json({ message : 'Access Denied' });
//     }

//     jwt.verify(token, process.env.SECRET, (err, user) => {
//         if (err) {
//             return res.status(403).json({ message : 'Access Denied' });
//         }

//         req.user = user;
//         next();
//     });
// };

// import jwt from 'jsonwebtoken';


// export const validateToken = (req, res, next) => {
//   Comentar las líneas relacionadas con la verificación del token
//   const authHeader = req.headers['authorization'];
//   const token = authHeader && authHeader.split(' ')[1];

//   if (token == null) {
//     return res.status(401).json({ message : 'Access Denied' });
//   }

//   jwt.verify(token, process.env.SECRET, (err, user) => {
//     if (err) {
//       return res.status(403).json({ message : 'Access Denied' });
//     }

//     req.user = user;
//     next();
//   });

//   Permitir acceso sin verificar el token
//   next();
// };

