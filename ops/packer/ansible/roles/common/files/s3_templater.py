from jinja2 import Template
import boto3
import yaml
import argparse

def main(argv=None):
    parser = argparse.ArgumentParser(description="Render config from S3 to a template")

    parser.add_argument('--bucket',
                        required=True)
    parser.add_argument('--key',
                        required=True)
    parser.add_argument('--template',
                        required=True)
    parser.add_argument('--file',
                        required=True)

    args = parser.parse_args(argv)

    s3 = boto3.resource('s3')
    obj = s3.Object(args.bucket, args.key)

    values = yaml.load(obj.get()['Body'].read().decode('utf-8'))

    with open(args.template) as file:
        template = Template(file.read())

    with open(args.file, 'w') as file:
        file.write(template.render(values))

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
