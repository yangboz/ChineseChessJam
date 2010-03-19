package com.vizsage.as3mathlib.math.calc {
/**
 * @class       com.vizsage.as3mathlib.math.calc.Fourier
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the static behaviours of the Fourier Class.
 * @usage       <code>Fourier.classMethod(args);</code>
 * @param       none  -- static methods are called directly without class instantiation.
 * -----------------------------------------------
 * Latest update: January 11, 2005
 * -----------------------------------------------
 * AS2 revision copyright: � 2005, Richard Wright [wisolutions2002@shaw.ca]
 * C   original copyright: � 1993, Paul Bourke [http://astronomy.swin.edu.au/~pbourke/analysis/dft/]
 * -----------------------------------------------
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     - Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *
 *     - Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 *     - Neither the name of this software nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * -----------------------------------------------
 * Functions:
 *       Fourier()
 *           1.  dft(dir, m, x_arr, y_arr)
 *           2.  fft(dir, m, x_arr, y_arr)
 *           3.  fft2D(comp_arr, nx, ny, dir)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

public class Fourier  {
    /**
     * @property none  -- no class properties.
    **/

    public function Fourier() {
        //trace ("Fourier Class loaded");
    }

      // 1. dft - Discrete Fourier Transform -----------

    /**
     * @method  dft
     * @description  Discrete Fourier transform -- this calculates an in-place
     *               complex-to-complex dft. x_arr and y_arr are the real and
     *               imaginary number arrays of 2^m points. This algorithm is
     *               about ten times slower than fft, but is useful when
     *               comparing many transforms.
     * @usage  <pre>Fourier.dft(dir, m, x_arr, y_arr);</pre>
     * @param   dir   (Number)  -- 1 gives forward transform, -1 gives reverse transform.
     * @param   m   (Number)  -- a positive integer.
     * @param   x_arr   (Array)  -- an array containing x-axis values for real number input.
     * @param   y_arr   (Array)  -- an array containing y-axis values for imaginary number input.
     * @return  (Boolean)
    **/
    public static function dft(dir:Number, m:Number, x_arr:Array, y_arr:Array):Boolean {
        var i:Number, k:Number;
        var arg:Number, cosarg:Number, sinarg:Number;
        var x2:Array = new Array(m);
        var y2:Array = new Array(m);

        if (x2.length==0 || y2.length==0) return false;

        for (i=0;i<m;i++) {
            x2[i] = 0;
            y2[i] = 0;
            arg = -dir*2.0*3.141592654*i/m;
            for (k=0;k<m;k++) {
                cosarg = Math.cos(k*arg);
                sinarg = Math.sin(k*arg);
                x2[i] += (x_arr[k]*cosarg-y_arr[k]*sinarg);
                y2[i] += (x_arr[k]*sinarg+y_arr[k]*cosarg);
            }
        }

        // Copy the data back
        if (dir==1) {
            for (i=0;i<m;i++) {
                x_arr[i] = x2[i]/m;
                y_arr[i] = y2[i]/m;
            }
        }
        else {
            for (i=0;i<m;i++) {
                x_arr[i] = x2[i];
                y_arr[i] = y2[i];
            }
        }

        return true;
    }

      // 2. fft - Fast Fourier Transform ---------------

    /**
     * @method  fft
     * @description  Fast Fourier transform -- this calculates an in-place
     *               complex-to-complex fft. x_arr and y_arr are the real and
     *               imaginary number arrays of 2^m points.
     *               <blockquote><pre>
     *               Formula: forward
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N-1
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1   \          - j k 2 pi n / N
     *               X(n) = ---   >   x(k) e                    = forward transform
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N   /                                n=0..N-1
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k=0
     *
     *               Formula: reverse
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N-1
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\          j k 2 pi n / N
     *               X(n) =       >   x(k) e                    = reverse transform
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/                                n=0..N-1
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k=0
     *               </pre></blockquote>
     * @usage  <pre>Fourier.fft(dir, m, x_arr, y_arr);</pre>
     * @param   dir   (Number)  -- 1 gives forward transform, -1 gives reverse transform.
     * @param   m   (Number)  -- a positive integer.
     * @param   x_arr   (Array)  -- an array containing x-axis values for real number input.
     * @param   y_arr   (Array)  -- an array containing y-axis values for imaginary number input.
     * @return  (Boolean)
    **/
    public static function fft(dir:Number, m:Number, x_arr:Array, y_arr:Array):Boolean {
        var i:Number, j:Number, k:Number, l:Number, n:Number, z:Number;
        var i1:Number, i2:Number, l1:Number, l2:Number, c1:Number, c2:Number;
        var tx:Number, ty:Number, t1:Number, t2:Number, u1:Number, u2:Number;

        // Calculate the number of points
        n = 1;
        for (i=0;i<m;i++) n *= 2;

        // Do the bit reversal
        i2 = n >> 1;
        j = 0;
        for (i=0;i<n-1;i++) {
            if (i<j) {
                tx = x_arr[i];
                ty = y_arr[i];
                x_arr[i] = x_arr[j];
                y_arr[i] = y_arr[j];
                x_arr[j] = tx;
                y_arr[j] = ty;
            }
            k = i2;
            while (k<=j) {
                j -= k;
                k >>= 1;
            }
            j += k;
        }
        //trace("m:"+m+", n:"+n+", j:"+j+", k:"+k);

        // Compute the fft
        c1 = -1.0;
        c2 = 0.0;
        l2 = 1;
        for (l=0;l<m;l++) {
            l1 = l2;
            l2 <<= 1;
            u1 = 1.0;
            u2 = 0.0;
            for (j=0;j<l1;j++) {
                for (i=j;i<n;i+=l2) {
                    i1 = i+l1;
                    t1 = u1*x_arr[i1]-u2*y_arr[i1];
                    t2 = u1*y_arr[i1]+u2*x_arr[i1];
                    x_arr[i1] = x_arr[i]-t1;
                    y_arr[i1] = y_arr[i]-t2;
                    x_arr[i] += t1;
                    y_arr[i] += t2;
                }
                z = u1*c1-u2*c2;
                u2 = u1*c2+u2*c1;
                u1 = z;
            }
            c2 = Math.sqrt((1.0-c1)/2.0);
            if (dir==1) c2 = -c2;
            c1 = Math.sqrt((1.0+c1)/2.0);
        }

        //trace('c1:'+c1+', c2:'+c2+', z:'+z);

        // Scaling for forward transform
        if (dir==1) {
            for (i=0;i<n;i++) {
                x_arr[i] /= n;
                y_arr[i] /= n;
            }
            //trace('n:'+n+' ..x:['+x+'], y:['+y+']');
        }

        return true;
    }

      // 3. fft2D -------------------------------------

    /**
     * @method  fft2D
     * @description  Performs a 2D fft in place given a complex 2D array.
     * @usage  <pre>Fourier.fft2D(comp_arr, nx, ny, dir);</pre>
     * @param  comp_arr  (Array)  -- a 2d array, each element contains a {re:val, im:val} Complex object.
     * @param  nx  (Number)  -- an integer, the size of the array rows.
     * @param  ny  (Number)  -- an integer, the size of the array columns.
     * @param  dir  (Number)  -- the direction dir, 1 for forward, -1 for reverse.
     * @return  (Boolean)  -- returns false if there are memory problems or the dimensions are not powers of 2
    **/
    public static function fft2D(comp_arr:Array, nx:Number = NaN, ny:Number = NaN, dir:Number = 1):Boolean {
        var i:Number, j:Number, m:Number, twopm:Number;
        var real:Number, imag:Number;
        var real_arr:Array = [];
        var imag_arr:Array = [];

        // Transform the rows
        real = nx;
        imag = nx;
        if (isNaN(real) || isNaN(imag)) return false;
        if (!(((nx-1)&nx)==0) || twopm!=nx) return false;
        for (j=0;j<ny;j++) {
            for (i=0;i<nx;i++) {
                real_arr[i] = comp_arr[i][j].real;
                imag_arr[i] = comp_arr[i][j].imag;
            }
            fft(dir, m, real_arr, imag_arr);
            for (i=0;i<nx;i++) {
                comp_arr[i][j].real = real_arr[i];
                comp_arr[i][j].imag = imag_arr[i];
            }
        }
        real_arr = [];
        imag_arr = [];

        // Transform the columns
        real = ny;
        imag = ny;
        if (isNaN(real) || isNaN(imag)) return false;
        if (!(((ny-1)&ny)==0) || twopm!=ny) return false;
        for (i=0;i<nx;i++) {
            for (j=0;j<ny;j++) {
                real_arr[j] = comp_arr[i][j].real;
                imag_arr[j] = comp_arr[i][j].imag;
            }
            fft(dir, m, real_arr, imag_arr);
            for (j=0;j<ny;j++) {
                comp_arr[i][j].real = real_arr[j];
                comp_arr[i][j].imag = imag_arr[j];
            }
        }
        real_arr = [];
        imag_arr = [];

        return true;
    }

}// class
}//package

