#Import-Module AWSPowerShell
Clear-Host

#users and policies
function user_listing{
$userlisting = (Get-IAMUserList).UserName
foreach ($u in $userlisting) {
    write-host "inspecting user" $u  -ForegroundColor red -BackgroundColor white
    echo "inspecting INLINE policies for user" $u | Out-File -FilePath C:\aws\users.json -Append
    aws iam list-user-policies --user-name $u | Add-Content C:\aws\users.json #IAM InlinePolicies 
    echo "inspecting AWS IAM managed policies for user" $u | Out-File -FilePath C:\aws\users.json -Append
    aws iam list-attached-user-policies --user-name $u | add-content C:\aws\users.json #IAM Managed policies  
}}

function group_listing{
$grouplisting = (Get-IAMGroupList).GroupName
foreach ($g in $grouplisting) {
    write-host "inspecting group" $g  -ForegroundColor red -BackgroundColor yellow
    echo "inspecting  INLINE policies for group" $g | Out-File -FilePath C:\aws\groups.json -Append
    aws iam list-group-policies --group-name $g | Add-Content C:\aws\groups.json #IAM InlinePolicies
    echo "inspecting AWS IAM managed policies for group" $g | Out-File -FilePath C:\aws\groups.json -Append
    aws iam list-attached-group-policies --group-name $g | Add-Content C:\aws\groups.json #IAM Group policies
    echo "listings members for group" $g | Out-File -FilePath C:\aws\groups.json -Append
    aws iam get-group --group-name $g | Add-Content C:\aws\groups.json #members
}}

function role_listing{
$rolelisting = (Get-IAMRoleList).RoleName
foreach ($r in $rolelisting) {
    write-host "inspecting role" $r  -ForegroundColor red -BackgroundColor DarkYellow 
    echo "inspecting  INLINE policies for role" $r | Out-File -FilePath C:\aws\roles.json -Append
    aws iam list-role-policies --role-name $r | Add-Content C:\aws\roles.json  #IAM InlinePolicies
    echo "inspecting AWS IAM managed policies for role" $r | Out-File -FilePath C:\aws\roles.json -Append
    aws iam list-attached-role-policies --role-name $r | Add-Content C:\aws\roles.json #IAM Group policies

}}

function policy_details{
$policylisting = (Get-IAMPolicyList -OnlyAttached 1).Arn
foreach ($p in $policylisting) {
    write-host "inspecting policy" $p  -ForegroundColor red -BackgroundColor Gray 
    echo "exporting policy for arn" $p | Out-File -FilePath C:\aws\policies.json -Append 
    aws iam get-policy --policy-arn $p | Add-Content C:\aws\policies.json  #detailed permissions for policies

}}

user_listing
group_listing
role_listing
policy_details
