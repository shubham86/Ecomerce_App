using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProChicken
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            find3Numbers();
        }

        bool find3Numbers()
        {
            int[] A = { 12, 5, 6, 2, 4, 8, 9, 11, 5, 7, 9, 2 };
            int arr_size = A.Length;
            int sum = 22;
            // Fix the first
            // element as A[i]
            for (int i = 0; i < arr_size - 2; i++)
            {

                // Fix the second
                // element as A[j]
                for (int j = i + 1; j < arr_size - 1; j++)
                {

                    // Now look for
                    // the third number
                    for (int k = j + 1; k < arr_size; k++)
                    {
                        if ((A[i] + A[j] + A[k]) == sum)
                        {
                            Label1.Text = "Triplet is " + A[i] + ", " + A[j] + ", " + A[k];
                            return true;
                        }
                    }
                }
            }

            // If we reach here,
            // then no triplet was found
            return false;
        }

    }
}