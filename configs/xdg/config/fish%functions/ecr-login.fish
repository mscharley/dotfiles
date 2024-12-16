function ecr-login --description "Login to AWS ECR"
	if test (count $argv) -lt 2
		echo "usage: ecr-login <profile> <region>" 1>&2
		return 1
	end
	aws ecr get-login-password --profile $argv[1] --region $argv[2] | docker login --username AWS --password-stdin $(aws configure --profile $argv[1] get sso_account_id).dkr.ecr.us-east-1.amazonaws.com
end
