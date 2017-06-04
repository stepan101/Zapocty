/*
Program pro vykreslování grafu funkce
Štěpán Picek, I. ročník
letní semestr 2015/16 
Programování II.(NPRG031)
*/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;



namespace Zapoctak
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            
        }
        public double chyb;         

        private void SouradnicovySystem() //vykreslení souřadnicového systému
        {
            int velX = panelGraf.Size.Width;
            int velY = panelGraf.Size.Height;
            double minX = -10, maxX = 10;
            double minY = -10, maxY = 10;

            minX = Convert.ToDouble(-hScrollBar1.Value);
            maxX = Convert.ToDouble(hScrollBar1.Value);
            minY = Convert.ToDouble(-hScrollBar1.Value);
            maxY = Convert.ToDouble(hScrollBar1.Value);

            Graphics g = panelGraf.CreateGraphics();
            g.Clear(Color.White);
           
            
            // vykreslení os a šipek
            g.DrawLine(new Pen(Color.Black, 2), new Point(0, velY / 2), new Point(velX, velY / 2));
            g.DrawLine(new Pen(Color.Black, 2), new Point(velX - 10, velY / 2 - 10), new Point(velX, velY / 2));
            g.DrawLine(new Pen(Color.Black, 2), new Point(velX - 10, velY / 2 + 10), new Point(velX, velY / 2));
            g.DrawLine(new Pen(Color.Black, 2), new Point(velX / 2, 0), new Point(velX / 2, velY));
            g.DrawLine(new Pen(Color.Black, 2), new Point(velX / 2 - 10, 0 + 10), new Point(velX / 2, 0));
            g.DrawLine(new Pen(Color.Black, 2), new Point(velX / 2 + 10, 0 + 10), new Point(velX / 2, 0));
           
            // vykreslení bodů na osách
            for (int i = 40; i < velX; i += 40)
            {
                if (i == velX / 2) continue;
                string st = (minX + i * ((maxX - minX) / velX)).ToString();
                g.DrawLine(new Pen(Color.Black, 2), 
                           new Point(i, velY / 2 + 5),
                           new Point(i, velY / 2 - 5));
                g.DrawString(st, new Font("Arial", 8), 
                                 new SolidBrush(Color.Black), 
                                 new PointF(i - 15, velY / 2 + 4));
            }
            for (int i = 40; i < velY; i += 40)
            {
                if (i == velY / 2) continue;
                string st = (minX + (velY - i) * ((maxY - minY) / velY)).ToString();
                g.DrawLine(new Pen(Color.Black, 2), 
                           new Point(velX / 2 + 5, i), 
                           new Point(velX / 2 - 5, i));
                g.DrawString(st, new Font("Arial", 8), 
                                 new SolidBrush(Color.Black), 
                                 new PointF(velX / 2 - 15, i + 4));
            }
            string point = "(" + (minX + (maxX - minX) / 2) + "; " + (minX + (maxY - minY) / 2) + ")";
            g.DrawString(point, new Font("Arial", 8), new SolidBrush(Color.Black), new PointF(velX / 2 - 15, velY / 2 + 4));

            // vykreslení mřížky
            for (int i = 0; i < velX; i += 20)
            {
                g.DrawLine(new Pen(Color.Gray), new Point(i, 0), new Point(i, velY));
            }
            for (int i = 0; i < velY; i += 20)
            {
                g.DrawLine(new Pen(Color.Gray), new Point(0, i), new Point(velX, i));
            }
        }

        private void Funkce()//vykreslení zadané funkce
        {
            chyba.Text = "";
            chyb = 0;
            int velX = panelGraf.Size.Width;
            int velY = panelGraf.Size.Height;
            double minX = -10, maxX = 10;
            double minY = -10, maxY = 10;

            minX = Convert.ToDouble(-hScrollBar1.Value);
            maxX = Convert.ToDouble(hScrollBar1.Value);
            minY = Convert.ToDouble(-hScrollBar1.Value);
            maxY = Convert.ToDouble(hScrollBar1.Value);
            SouradnicovySystem();

            double pi = Math.PI;
            double e = Math.E;
            Graphics g = panelGraf.CreateGraphics();

            string vyraz = textbox.Text;

            Promenne = new Dictionary<string, string>();
            Promenne.Add("x", "-101");
            Promenne.Add("pi", pi.ToString());
            Promenne.Add("e", e.ToString());

            Point Bod = new Point();
            Point preBod = new Point();
            bool jetoBod = false;
            bool jetopreBod = false;
            double y=1;
            //Výpočet všech f(x) na itervalu
            for (double x = minX; x < maxX; x += (maxX - minX) / velX)
            {
                string a = x.ToString();
                Promenne.Remove("x");
                Promenne.Add("x", a);
                if (chyb==2)//kontrola
                {
                    chyba.Text = "Špatně zadaný výraz.";
                    break;
                }
                else
                {
                        y = Vyhodnoceni(vyraz);
                        jetoBod = true;
                }
                //body, co tam nepatří
                if (Math.Abs(y) > maxY * 2) jetoBod = false;

                //nový bod
                if (jetoBod)
                {
                    Bod.X = (int)(x / ((maxX - minX) / velX) - minX / ((maxX - minX) / velX));
                    Bod.Y = (int)(velY - (y / ((maxY - minY) / velY) - minY / ((maxY - minY) / velY)));
                    if (jetopreBod)
                    {
                        try { 
                        g.DrawLine(new Pen(Color.Red, 2), preBod, Bod);
                            //spojení předchozího bodu s původním
                        }
                        catch { }
                    }
                }
                preBod = Bod;
                jetopreBod = jetoBod;
            }
           
        }
        //uložení proměnné x, pí, e
        private Dictionary<string, string> Promenne;

        //priorita jednotlivých operací
        private enum Priorita
        {
            None = 4,
            Exp = 3,     
            Nasob = 2,
            Scitat = 1,
        }
        // kliknutí na tlačítko - vykreslení funkce
        private void button1_Click(object sender, EventArgs e)
        {
            if (textbox.Text == "")
            {
                chyba.Text = "Prázdné pole";
            }
            else { 
            Funkce();
            }

        }
        // hlavní funkce vyhodnocení výrazu při dosazení x
        private double Vyhodnoceni(string vyr)
        {
            int nej_poz = 0;
            int rodic = 0;
            //odstranění mezer
            string vyraz = vyr.Replace(" ", "");
            int delka = vyraz.Length;
            if (delka == 0) return 0;

            bool je_unarni = true;

            Priorita nej_prior = Priorita.None;
            //procházení všech pozic a určení priorit jednotlivých znamének 
            for (int poz = 0; poz < delka; poz++)
            {
                string ch = vyraz.Substring(poz, 1);

                bool dalsi_unarni = false;

                 if (ch == "(")
                {
                    rodic += 1;
                    dalsi_unarni = true;
                }
                else if (ch == ")")
                {
                    rodic -= 1;
                    dalsi_unarni = false;
                }

                else if (rodic == 0)
                {
                    if ((ch == "^") || (ch == "*") ||
                        (ch == "/") || (ch == "+") ||
                        (ch == "-"))
                    {
                        dalsi_unarni = true;

                        switch (ch)
                        {
                            case "^":
                                if (nej_prior >= Priorita.Exp)
                                {
                                    nej_prior = Priorita.Exp;
                                    nej_poz = poz;
                                }
                                break;
                            case "*":
                            case "/":
                                if (nej_prior >= Priorita.Nasob)
                                {
                                    nej_prior = Priorita.Nasob;
                                    nej_poz = poz;
                                }
                                break;
                            case "+":
                            case "-":
                                if ((!je_unarni) &&
                                   nej_prior >= Priorita.Scitat)
                                {
                                    nej_prior = Priorita.Scitat;
                                    nej_poz = poz;
                                }
                                break;


                        }
                    }
                }
                je_unarni = dalsi_unarni;
            }
            //Rekurzivní vyhodnocení výrazů podle znamének
            if (nej_prior < Priorita.None)
            {
                string leva = vyraz.Substring(0, nej_poz);
                string prava = vyraz.Substring(nej_poz + 1);
                switch (vyraz.Substring(nej_poz, 1))
                {
                    case "^":
                        if (Vyhodnoceni(prava) < 1 && Vyhodnoceni(prava) > 0 && Vyhodnoceni(leva) < 0)
                        {
                            return -999;
                        }
                        else return Math.Pow(
                        Vyhodnoceni(leva),
                        Vyhodnoceni(prava));
                    case "*":
                        return
                            Vyhodnoceni(leva) *
                            Vyhodnoceni(prava);
                    case "/":
                        return
                            Vyhodnoceni(leva) /
                            Vyhodnoceni(prava);
                    case "%":
                        return
                            Vyhodnoceni(leva) %
                            Vyhodnoceni(prava);
                    case "+":
                        return
                            Vyhodnoceni(leva) +
                            Vyhodnoceni(prava);
                    case "-":
                        return
                            Vyhodnoceni(leva) -
                            Vyhodnoceni(prava);

                }
            }
            if (vyraz.StartsWith("(") && vyraz.EndsWith(")"))
            {
                
                return Vyhodnoceni(vyraz.Substring(1, delka - 2));
            }

            if (vyraz.StartsWith("-"))
            {
                return -Vyhodnoceni(vyraz.Substring(1));
            }
            if (vyraz.StartsWith("+"))
            {
                return Vyhodnoceni(vyraz.Substring(1));
            }
            if (delka > 5 && vyraz.EndsWith(")"))
            {
                // nalezení první závorky
                int paren_pos = vyraz.IndexOf("(");
                if (paren_pos > 0)
                {
                    // Typ funkce
                    string leva = vyraz.Substring(0, paren_pos);
                    string prava = vyraz.Substring(paren_pos + 1, delka - paren_pos - 2);
                    switch (leva.ToLower())
                    {
                        case "sin":
                            return Math.Sin(Vyhodnoceni(prava));
                        case "cos":
                            return Math.Cos(Vyhodnoceni(prava));
                        case "tg":
                        case "tan":
                            return Math.Tan(Vyhodnoceni(prava));
                        case "sqrt":
                            {
                                if (Vyhodnoceni(prava) >= 0)
                                {
                                    return Math.Sqrt(Vyhodnoceni(prava));
                                }
                                else return -999;
                            }
                        case "cotan":
                        case "cot":
                        case "cotg":
                            return 1 / Math.Tan(Vyhodnoceni(prava));
                        case "asin":
                            {
                                if (Vyhodnoceni(prava) >= -1 && Vyhodnoceni(prava) <= 1)
                                {
                                    return Math.Asin(Vyhodnoceni(prava));
                                }
                                else return -999;
                            }
                        case "acos":
                            {
                                if (Vyhodnoceni(prava) >= -1 && Vyhodnoceni(prava) <= 1)
                                {
                                    return Math.Acos(Vyhodnoceni(prava));
                                }
                                else return -999;
                            }
                        case "atg":
                        case "atan":
                            {
                                return Math.Atan(Vyhodnoceni(prava));
                            }
                        case "abs":
                            return Math.Abs(Vyhodnoceni(prava));
                        case "ln":
                        case "log":
                            {
                                if (Vyhodnoceni(prava) > 0)
                                {
                                    return Math.Log(Vyhodnoceni(prava));
                                }
                                else return -999;
                            }
                        case "sign":
                            return Math.Sign(Vyhodnoceni(prava));

                    }
                }
            }
            //nalezení proměnné x a zkouška výpočtu
            if (Promenne.ContainsKey(vyraz))
            {               
                try
                {
                    return double.Parse(Promenne[vyraz]);
                }
                catch 
                {}
            }
             //Pokud není překlep, vyhodnotí výraz          
            try
            {                
                return double.Parse(vyraz);
            }
            catch 
            {                
                return chyb=2;
            }
  }
       //Posuvník - přibližovátko
        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
            Funkce();
        }
               
    }
    
}
