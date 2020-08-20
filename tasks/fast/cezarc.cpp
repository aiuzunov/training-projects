#include<iostream>
#include<map>
#include<vector>
#include<string>
#include<algorithm>
using namespace std;
struct bukva
{
    char firstword;
    int ct;
    bukva(){};
    bukva(char c,int otherwords)
    {
        firstword=c;
        ct=otherwords;
    }
};
bool operator<(bukva firstletter,bukva secondletter)
{
    return firstletter.ct<secondletter.ct;
}
map<char,int> after;
vector<bukva> bukvi;
int main(){
    int n,x,y;
    cin>>n;
    string firstword,otherwords;
    cin >> firstword;
    while(firstword.length() > 10)
    {
    cin >> firstword;
    }
    for(int i=0;i<firstword.size();i++)
    {
        after[firstword[i]]=1;
    }
    for(int i=1;i<n;i++)
    {
        cin >> otherwords;
        while(otherwords.length() > 10)
        {
          cin >> otherwords;
        }
        x=0;
        y=0;
        while(x<firstword.size()&&y<otherwords.size())
        {
            if(firstword[x]!=otherwords[y])
            {
                if(!after[otherwords[y]])
                {
                    after[otherwords[y]]=1;
                }
                after[otherwords[y]]++;
                y++;
                break;
            }
            x++;
            y++;
        }
        while(y<otherwords.size())
        {
            if(!after[otherwords[y]])
            {
                after[otherwords[y]]=1;
            }
            y++;
        }
        firstword=otherwords;
    }
    map<char,int>::iterator it=after.begin();
    for(;it!=after.end();it++)
    {
        bukvi.push_back(bukva(it->first,it->second));
    }
    sort(bukvi.begin(),bukvi.end());
    if(bukvi[0].ct>1)
    {
        cout<<"No\n";
        return 0;
    }
    cout<<"Yes\n";
    for(int i=0;i<bukvi.size();i++)
    {
            cout<<bukvi[i].firstword;
    }
    char c;
    for(int i=0;i<26;i++)
    {
        if(!after['a'+i])
        {
            c='a'+i;
            cout<<c;
        }
    }
    cout<<"\n";
    return 0;
}
