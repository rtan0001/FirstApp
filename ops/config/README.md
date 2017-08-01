# Environment configuration

This folder contains the environment specific config items.


Suggested structure is to have a single json file per environment.

eg `dev.json`

Each file should have separate sections for the different config sections.

For example:

```
{
    "cloudformation": {
        "vpcID":  "vpc-f079f595",

        "publicSubnetA": "subnet-54788f22",
        "publicSubnetB": "subnet-868c47e2",

        "KMSMasterKeyARN": "arn:aws:kms:ap-southeast-2:439149920780:key/4a170d75-a9d8-4974-b150-88dc2b614b04"
    },
    "msbuild": {
        "public_dns_name": "uet-dev.apps.monash.edu",
        "sso_server_dns_name": "login-idmqa.monash.edu",
    }
}
```

## Secret data

There may be a need to encrypt some of the parameters stored in the configuration, for example the `DBpassword` parameter.

This can be achieved by using the KMS service to encrypt the value, and then have the `deploy_application.py` script able to decrypt the parameter as part of the deployment.

**To encrypt a string**

Use the AWS command line tools to supply the plaintext value like:

```
$ aws kms encrypt --key-id "arn:aws:kms:ap-southeast-2:439149920780:key/9784adf5-e387-4a45-a876-05482cced84e" --plaintext secrettext
```

This will return the cipertext that can be stored in the configuration.

```
{
    "KeyId": "arn:aws:kms:ap-southeast-2:439149920780:key/9784adf5-e387-4a45-a876-05482cced84e",
    "CiphertextBlob": "AQECAHg8w+3EMQLpKb1FQ/w31AiXYaPuJvSC1IEaS6K+lXuqLAAAAGgwZgYJKoZIhvcNAQcGoFkwVwIBADBSBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDCpo6LgfXFs6NflWGgIBEIAlttdpGlEHanorfqU/U/9si+s0rYh
9IpAi4f5RqBCxyUFYWc6ztg=="
}
```

**To store the encrypted value**

A special set of delimiters are required in the configuration to ensure that the `deploy_application.py` knows the value is encrypted and should be decrypted before being sent on to CloudFormation.

To store the above encrypted blob in the configuration, use the `KMSEncrypted` and `/KMSEncrypted` keywords to delimit the value.

```
{
    "DBuser": "ugmdevdbuser",
    "DBpassword": "KMSEncryptedAQECAHg8w+3EMQLpKb1FQ/w31AiXYaPuJvSC1IEaS6K+lXuqLAAAAGgwZgYJKoZIhvcNAQcGoFkwVwIBADBSBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDCpo6LgfXFs6NflWGgIBEIAlttdpGlEHanorfqU/U/9si+s0rYh9IpAi4f5RqBCxyUFYWc6ztg==/KMSEncrypted",
    "DBclass": "db.m4.large",    
}
```
