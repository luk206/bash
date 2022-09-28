
if [[ $# -eq 0 ]] ; then
    echo "Usage: $0 PROFILEPATTERN BUCKETNAME"
    exit 1
fi

PROFILEPATTERN=$1
BUCKETNAME=$2

for i in $(aws configure list-profiles | grep "${PROFILEPATTERN}"); do
  BUCKET=${BUCKETNAME};
  export AWS_PROFILE=${i}
  AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
  aws s3 ls | grep "${BUCKET}" && echo "${i}" && echo "${AWS_ACCOUNT_ID}" ;
done