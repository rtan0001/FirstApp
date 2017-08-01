import argparse
import boto3
from Crypto.Cipher import AES
import base64
from subprocess import call
import json
from urllib import urlopen
import os

def main(argv=None):
    if os.environ.has_key('AWS_REGION'):
        region = os.environ['AWS_REGION']
    elif os.environ.has_key('AWS_DEFAULT_REGION'):
        region = os.environ['AWS_DEFAULT_REGION']
    else:
        region = json.loads(urlopen("http://169.254.169.254/latest/dynamic/instance-identity/document").read())['region']

    parser = argparse.ArgumentParser(description="Render config from S3 to a template")

    parser.add_argument('--action',
                        required=True)
    parser.add_argument('--bucket',
                        required=True)
    parser.add_argument('--filename',
                        required=True)
    parser.add_argument('--env',
                        required=True)
    args = parser.parse_args(argv)

    kms = boto3.client('kms', region_name=region)
    s3 = boto3.client('s3', region_name=region)

    if args.action == 'get':
        encrypted_key = s3.get_object(
            Bucket=args.bucket,
            Key="{0}/{0}.key".format(args.env)
        )['Body'].read()
        encrypted_data = s3.get_object(
            Bucket=args.bucket,
            Key="{0}/{1}".format(args.env, args.filename)
        )['Body'].read()

        plaintext_key = kms.decrypt(
            CiphertextBlob=encrypted_key
        )
        # import code; code.interact(local=dict(globals(), **locals()))

        crypter = AES.new(plaintext_key['Plaintext'])
        plaintext_data = crypter.decrypt(base64.b64decode(encrypted_data))
        with open(args.filename, 'wb') as output_file:
            output_file.write(plaintext_data)
        print('GET: Success')

    elif args.action == "put":
        key = kms.generate_data_key(
            KeyId='alias/ugm_' + args.env,
            KeySpec='AES_256'
        )
        with open(args.filename) as plaintext_data:
            crypter = AES.new(key['Plaintext'])
            encrypted_data = base64.b64encode(crypter.encrypt(pad(plaintext_data.read())))
            s3.put_object(
                Bucket=args.bucket,
                Key="{0}/{0}.key".format(args.env),
                Body=key['CiphertextBlob']
            )
            s3.put_object(
                Bucket=args.bucket,
                Key="{0}/{1}".format(args.env, args.filename),
                Body=encrypted_data
            )
if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass