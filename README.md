# github issue export script

- Sample script to export pull requests and issues from github as CSV file.
- I'd recommend to use this repository by forking to your private space and edit the conditions in the files.

## Setup


Create access token on GitHub
https://github.com/settings/tokens?type=beta

Required permission on a specific repository.
- Read permission for issues.
- Read permission for Pull Requests.


Paste the generated token into .env file.
```
% cp .env.sample .env
% vi .env
```

## Execute

Export github issues with specific culumns.
This script supports auto pagination.

```
% bash export.sh
```


## screenshot

![image](https://user-images.githubusercontent.com/98103/204869744-5950c7a9-213e-4cf5-b9e6-2787a3a24a75.png)
