"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPresignedUrl = void 0;
const s3_1 = __importDefault(require("aws-sdk/clients/s3"));
async function getPresignedUrl(event) {
    let url = await getUploadUrl();
    let res = {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            uploadUrl: url
        })
    };
    return res;
}
exports.getPresignedUrl = getPresignedUrl;
async function getUploadUrl() {
    let s3 = new s3_1.default();
    let params = {
        Bucket: process.env.S3_BUCKET,
        Key: 'test.jpg',
        Expires: 60,
    };
    let url = s3.getSignedUrl('putObject', params);
    return url;
}
//# sourceMappingURL=upload.js.map