import jwt from 'jsonwebtoken';

export const validateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (token == null) {
        return res.sendStatus(401).json({ message : 'Access Deniend' });
    }

    jwt.verify(token, process.env.SECRET, (err, user) => {
        if (err) {
            return res.sendStatus(403).json({ message : 'Accesso denegado'});
        }

        req.user = user;
        next();
    });
};