"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPresignedUrl = void 0;
const s3_1 = __importDefault(require("aws-sdk/clients/s3"));
const uuid_1 = require("uuid");
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
    let filename = uuid_1.v4();
    let params = {
        Bucket: process.env.UPLOAD_BUCKET,
        Key: filename,
        ContentType: 'image/jpeg',
        Expires: 60,
    };
    let url = s3.getSignedUrl('putObject', params);
    return url;
}
//# sourceMappingURL=upload.js.map