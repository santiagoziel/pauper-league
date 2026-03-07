import 'dotenv/config';
import express, { Request, Response } from 'express';
import { prisma } from './lib/prisma';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(express.json());

app.get('/', (req: Request, res: Response) => {
  prisma.user.findMany().then(users => {
    console.log(users);
  }).catch(error => {
    console.error('Error fetching users:', error);
  });
  res.json({ message: 'Hello, World!' });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
