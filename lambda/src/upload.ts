import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';
import S3 from 'aws-sdk/clients/s3';

export async function getPresignedUrl(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    let url = await getUploadUrl();
    let res = {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            uploadUrl: url
        })
    }
    return res
}

async function getUploadUrl(): Promise<string> {
    let s3 = new S3();
    let params = {
        Bucket: process.env.UPLOAD_BUCKET,
        Key: 'test.jpg',
        Expires: 60, // 60 second expiry on URL
    }

    let url = s3.getSignedUrl('putObject', params);
    return url
}

