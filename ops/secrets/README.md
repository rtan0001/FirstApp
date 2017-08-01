

# Encrypted and unencrypted values

 - By default, sops will encrypt all of the values in a config file. This behaviour can be overridden by adding a suffix (by default `_unencrypted`) to the key name, which will cause the corresponding value to be stored in plaintext
 - Adding this prefix to a top-level key with sub-keys will make ALL the values under this key unencrypted


 - KMS is an AWS service that manages encryption keys. Multiple keys can be created, and individual IAM policies can be applied to them, allowing for fine-grained access control to the files that have been encypted using these keys.
 - To store sensitive details (passwords, keys etc.) in a secure fashion, whilst still remaining accessable to applications and developers, we store key/value files in S3. The sensitive values in these files are encrypted using KMS keys.
 - To facilitate the encryption, decryption and management of these encrypted files, we use a Python library called sops. Sops allows us to specify different keys to use with different file patterns (for instance, one key for `*.dev.yaml` files, and a seperate one for `*.prod.yaml` files). The matching of keys to files is handled using a `.sops.yaml` configuration file in the base of your working directory. When encrypting a new file, sops will search this file for any rule that matches, and use the corresponding key to encrypt any secrets. More information about sops command line usage can be found at https://pypi.python.org/pypi/sops
 - As things currently stand, the names used for secrets in UGM must follow the convention `ugm.ENV.yaml` and be stored in the `monash-ugm-poc` bucket, where `ENV` is an environment variable relating to the stack environment (dev, staging, qa etc). Further, the system is currently only set up to inject secrets into the `ugeprops.xml` file. To add new secrets to this file, edit the template at `packer/ansible/roles/ugm/files/ugeprops.xml.jinja`. Variable names between this file and the secrets file must match.

# Bootstrapping a new environment

 - If you are deploying the UGM application into a brand new AWS environment, there are some prerequisites you will need to set up first:
  1. Create a KMS master key. This can be done in the IAM console of AWS. This is the key that will be used to encrypt/decrypt your secrets. You can create multiple keys, spanning multiple regions, to increase availability.
  2. Add the keys to the .sops.yaml file. This file matches a regex with the set of keys to use for matching files. If no regex is specified, the keys will be used for any file not matching other regexes. For example
  ```
  - filename_regex: \.poc\.ya?ml$
    kms: arn:aws:kms:ap-southeast-2:224093794013:key/3406f274-9cf1-43b1-a8d1-0b35c896c220
  ```
  will match YAML files with a .poc.yaml suffix.
  3. Encypt your secrets. Running sops FILENAME will open the file in your text editor (defined by $EDITOR), and encrypt the values when the editor is closed.
  4. Upload the secrets. There is a script to help with this: `python upload.py --bucket BUCKET_NAME`
  5. Ensure that the IAM policy attached to your deployment instance has the appropriate permissions to access/use the master KMS key.
