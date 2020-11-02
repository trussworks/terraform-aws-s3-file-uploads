import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';
import S3 from 'aws-sdk/clients/s3';
import { v4 as uuidv4 } from 'uuid';

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
    let filename = uuidv4()

    let params = {
        Bucket: process.env.UPLOAD_BUCKET,
        Key: filename,
        ContentType: 'image/jpeg',
        Expires: 60, // 60 second expiry on URL
    }

    let url = s3.getSignedUrl('putObject', params);
    return url
}

