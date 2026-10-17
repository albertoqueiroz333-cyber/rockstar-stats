# rockstar-stats

## Salvar estatísticas

O formulário envia os dados por `POST /stats` como
`application/x-www-form-urlencoded`. O endpoint salva ou atualiza o jogador na
tabela `public.gta`, usando `PLAYER_ID` como chave.

Campos obrigatórios:

- `PLAYER_ID`: texto de 1 a 100 caracteres
- `COPS_KILLED`, `VEHICLES_STOLEN`, `STORE_HOLD_UPS`,
  `MURDERED_CIVILIANS`: inteiros não negativos

Em caso de sucesso, retorna HTTP `200` com o `PLAYER_ID` salvo. Erros de entrada
retornam HTTP `400`; indisponibilidade de configuração do banco retorna `503`.