import boto3
import json

def main():
    client = boto3.client(
            "runtime.sagemaker",
            region_name="eu-west-2",
        )

    payload = {
        "term": 48,
        "credit_band": "I",
        "employment_status": "full_time_permanent",
        "residential_status": "private_tenant",
        "advance": 7100,
        "customer_age": 40
    }

    response = client.invoke_endpoint(
        EndpointName="rep-rate-clearscore-endpoint-temp",
        ContentType="application/json",
        Body=json.dumps([payload]),
    )

    print(response)

    print(json.loads(response["Body"].read().decode()))


if __name__ == "__main__":
    main()