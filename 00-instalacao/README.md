# Instalação

### 01) Fazendo download do dataset no Kaggle

- city-of-seattle/seattle-library-collection-inventory
- considerar que ja existe o arquivo `~/.kaggle/kaggle.json` com dados de usuario

```
$ sh 01-download-dataset.sh
```
### 2) Quebrando o dataset em arquivos menores
O dataset possui 11GB e a ideia é quebrar em arquivos menores com 100 mil linhas cada um

```
$ sh 02-break-dataset.sh
```

### 3) Criando os recursos na AWS usando Terraform

Provisionamento dos recursos S3, SQS com DLQ e Kinesis Firehose na plataforma de Cloud AWS

```
$ sh 03-infra.sh
```

| Recurso / Módulo                     | Nome                                                  |
|--------------------------------------|-------------------------------------------------------|
| s3-bucket*                           | s3-fiap-grupo-o                                       |
| sqs-with-dlq*                        | raw_json<br/>raw_json-dead-letter-queue               |
| sqs-with-dlq*                        | small_files_csv<br/>small_files_csv-dead-letter-queue |
| aws_kinesis_firehose_delivery_stream | firehose-grupo-o-ingest-json                          |
| aws_iam_policy                       | s3_policy_grupo_o                                     |
| aws_iam_role                         | firehose_role_grupo_o                                 |

* Criado usando Módulo