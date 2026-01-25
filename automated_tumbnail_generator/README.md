# Automated Thumbnail Generator (Python, AWS Lambda, S3)

## Overview

This project is a simple automated thumbnail generator that uses Python, AWS Lambda, and S3 to generate thumbnails of images uploaded to an S3 bucket.

As soon as an image is uploaded to the S3 bucket/images folder, the AWS Lambda Function is triggered to generate a thumbnail of the image and store it in the S3 bucket/thumbnails folder.

## Features

- Generate thumbnails of images uploaded to an S3 bucket
- Use AWS Lambda Function to generate thumbnails
- Use S3 Bucket to store the thumbnails

## Architecture


## Setup

1. Create an S3 Bucket
2. Create an AWS Lambda Function
3. Create an AWS Lambda Function Policy
4. Create an AWS Lambda Function Role
5. Create an AWS Lambda Function Policy Attachment