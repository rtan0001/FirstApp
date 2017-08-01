import argparse
import boto3
import glob
import os
def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument('--bucket',
                        required=True,
                        help='Bucket to upload to')
    args = parser.parse_args(argv)

    s3 = boto3.resource('s3')

    for file in glob.glob('./*.yaml'):
        data = open(file, 'rb')
        s3.Bucket(args.bucket).put_object(Key=os.path.basename(file), Body=data)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
