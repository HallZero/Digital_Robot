# Digital_Robot
O projeto Robô Digital tem por objetivo a elaboração de uma solução completa de integração entre as Tecnologias de Automação (TA) e as Tecnologias de Informação (TI). Trata-se de uma representação digital para um braço robótico com conexão em tempo real com sua contrapartida no mundo real.

## API

A API encontra-se no arquivo app.py e faz uso do Flask junto com SQLAlchemy

### Rotas

- `/`: Esta rota carrega a página principal "index.html"
- `/test`: Funcionalidade de teste. Retorna a string "teste"
- `/position`: Acessada pelo método POST, guarda as informações digitadas no formulário presente na "index.html" em um banco de dados
- `/axes`: Retorna um JSON com as informações das coordenadas

