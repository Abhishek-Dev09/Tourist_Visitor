clear

AutoNumber()
{
            local tid=0     
            while read line; do
                tid=`expr $tid + 1`
            done < Payment.txt
            tid=`expr $tid + 1`
            echo $tid
}

Payment()
{
            clear
           
            tid=$1
            echo "Enter Tourtist ID: $tid"
           
            echo "Enter Tourtist Name: "
            read tname

            echo "Enter Hotel name: "
            read hname

            echo "Enter Date and time: "
            read ttime
           
            echo "Enter Amount to paid in INR: "
            read amt
            amount="Rs $amt" 

            echo "$tid,$tname,$hname,$ttime,$amount" >> Payment.txt
            

            echo "                 Payment Database Created sucessfully                           "

}

View_Payment()
{
      
            echo "_________________________________________________________________________________________"                       
            echo "                              Payment Details "
            echo "_________________________________________________________________________________________"                       
            echo "#ID TouristName           Hotel Name              Date & Time                Amount "
            echo "_________________________________________________________________________________________"                       

            local IFS=$',\n'
            while read line; do
                a=$line
                local f=0
                for x in $a
                do
                    if [ $f -eq 0 ]; then
                        printf "$x "
                        f=1
                    else
                        printf "$x           "
                    fi
                done
                echo ""
            done < Payment.txt
            local IFS=$' \t\n'
            echo "_____________________________________________________________________________________________"                       
}

cancel()
{
            clear

            echo "Enter Hotel ID: "
            read hid

            echo "Enter Hotel name: "
            read hname

            echo "Enter Cancellation Policy: "
            read can
            echo "$hid,$hname,$can" >> Cancellation.txt

            echo "                 Cancellation Database Created sucessfully                           "

}

View_Cancel()
{
      
            echo "______________________________________________________________________________________________________________________________________________________________________________________________________"                       
            echo "                                                      Cancellation Policies "
            echo "______________________________________________________________________________________________________________________________________________________________________________________________________"                       
            echo "______________________________________________________________________________________________________________________________________________________________________________________________________"                       
            echo "#HotelID Hotel Name                                   Cancellation Policies"    
            echo "______________________________________________________________________________________________________________________________________________________________________________________________________"                       

            local IFS=$',\n'
            while read line; do
                a=$line
                local f=0
                for x in $a
                do
                    if [ $f -eq 0 ]; then
                        printf "$x       "
                        f=1
                    else
                        printf "$x    "
                    fi
                done
                echo ""
            done < Cancellation.txt
            local IFS=$' \t\n'              
            echo "__________________________________________________________________________________________________________________________________________________________________________________________________"                       
}

Add_Hotel()
{
            clear
           
            echo "Enter Hotel ID: "
            read hid

            echo "Enter Hotel name: "
            read hname

            echo "Enter Address: "
            read add

            echo "Enter price in INR: "
            read price

            echo "AC or Non AC- Enter Y/N for Yes/No : "
            read ac

            echo "Does it provide free parking - Enter Y/N for Yes/No: "
            read park
            
            echo "Does it provide free wifi - Enter Y/N for Yes/No: "
            read wifi
            
            echo "$hid,$hname,$add,$price,$ac,$park,$wifi">> Hotel.txt

            echo "                 Hotel Database Created sucessfully                           "

}

Add_review()
{

             echo "Enter Hotel name for which you want to review: "
             read hotelname
             echo "____________________________________________________________"                       
             echo "                        Hotel Details                       "
             echo "____________________________________________________________"                       
             flag=0
             line="$(grep "$hotelname" Hotel.txt)"
             IFS="," read hid hname add price ac park wifi <<< "$line"
             if [ "$hotelname" == "$hname" ]
             then
              flag=1
              echo "_____________________________________________________________"                        
              echo " HotelID : $hid                Hotel Name : $hname            "  
              echo "_______________________________________________________________"                        
              echo "  Address Of the Hotel         : $add   "
              echo "  Price Of the Hotel           : Rs $price   "
              echo "  AC Or Non-AC                 : $ac   "   
              echo "  Does it provide free Parking : $park   "
              echo "  Does it provide free wifi    : $wifi   "
              echo "_______________________________________________________________" 
              echo "Enter the review of this hotel "
              read review
              newLine="$hid,$hname,$add,$price,$ac,$park,$wifi,$review"
              oldLine="$hid,$hname,$add,$price,$ac,$park,$wifi"
              sed -i "" "s/$oldLine/$newLine/g" Hotel.txt
              echo "Your review has been added as : $review"
             fi
             
             if [ $flag = 0 ]
             then
                 echo "               No Hotel Found              "
             fi
            
            
}

Add_rating()
{
             clear

             echo "Enter Hotel name for which you want to rate: "
             read hotelname
             echo "_________________________________________________________________"                       
             echo "                             Hotel Details                       "
             echo "_________________________________________________________________"                       
             flag=0
             line="$(grep "$hotelname" Hotel.txt)"
             IFS="," read hid hname add price ac park wifi review <<< "$line"
             if [ "$hotelname" == "$hname" ]
                then
                flag=1
                echo "_______________________________________________________________"                        
                echo " HotelID : $hid                 Hotel Name : $hname            "  
                echo "_______________________________________________________________"                        
                echo "  Address Of the Hotel         : $add   "
                echo "  Price Of the Hotel           : $price   "
                echo "  AC Or Non-AC                 : $ac   "   
                echo "  Does it provide free Parking : $park   "
                echo "  Does it provide free wifi    : $wifi   "
                echo "  Review  of a Hotel           : $review   "
                echo "_______________________________________________________________"
                echo "Rate this hotel in 0-5 :"
                read rate 
                newLine="$hid,$hname,$add,$price,$ac,$park,$wifi,$review,$rate"
                oldLine="$hid,$hname,$add,$price,$ac,$park,$wifi,$review"
                sed -i "" "s/$oldLine/$newLine/g" Hotel.txt
                echo "Your rating has been added : $rate"                                  
              fi
            
             if [ $flag = 0 ]
             then
                 echo "               No Hotel Found              "
             fi
               echo "__________________________________________________________________"  
            
                     
}

while [ true ]
do
echo " _______________________________"
echo " 1. View Invoice"
echo " 2. View the Cancellation Policies"
echo " 3. Add review of a Hotel"
echo " 4. Add rating to a Hotel"
echo " 5. Exit    "
echo " _______________________________" 
echo "Enter Choice: "
read ch

case $ch in

            1)
               nxtSrNo=$(AutoNumber)
               Payment $nxtSrNo
               View_Payment ;;
            2) cancel
               View_Cancel ;;
            3) Add_Hotel 
               Add_review ;;
            4) Add_rating ;;
            5) break;;
            *) echo " Wrong Choice "
esac
done