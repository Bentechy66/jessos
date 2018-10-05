#handle up and down keys for previous commands?
pattern="^[^a-z]*$"

function commandToLower()
{
        count=1
        result=""
        for i in $1
        do
                if [ $count == 1 ]
                then
                        result+=`echo "${i}" | tr '[A-Z]' '[a-z]'`
                        result+=" "
                else
                        result+="$i"
                        result+=" "
                fi
                count=$((count+1))
        done
        echo $result
}

function checkCaps(){
        count=1
        for i in $1
        do
                if [ $count == 1 ]
                then
                        if [[ $i =~ $pattern ]]
                        then
                                return 0
                        else
                                return 1
                        fi
                else
                        return 1
                fi
        done
        return 1
}

while [ true ]
do
        echo -n "> "
        read Command
        if [ "$Command" != "" ]
        then
                if checkCaps "$Command"
                then
                        sudo $(commandToLower "$Command")
                else
                        $(commandToLower "$Command")
                fi
        else
                echo -n ""
        fi
done