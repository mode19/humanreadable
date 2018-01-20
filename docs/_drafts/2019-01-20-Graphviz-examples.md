---
layout: post
title:  "Graphviz Ideas"
date:   2017-01-01
categories: graphviz
---

## Architecture diagram

{% dot %}
    digraph architecture {
		node [shape=none]
		UX [label=<<TABLE border="2" cellspacing="5" cellpadding="5" style="rounded"><TR><TD border="0">UX LAYER</TD></TR></TABLE>>];
		INT [label=<<TABLE border="2" cellspacing="5" cellpadding="5" style="rounded"><TR><TD border="0">INTEGRATION LAYER</TD></TR></TABLE>>];
		BK [label=<<TABLE border="2" cellspacing="5" cellpadding="5" style="rounded"><TR><TD border="0">BK</TD></TR></TABLE>>];

		UX -> INT
	    INT-> BK			
    }

{% enddot %}


## Sequence work flow
{% dot %}

digraph G { bgcolor="yellow:red" 
  subgraph cluster1 {fillcolor="blue:green" style="filled"
		node [shape=diamond fillcolor="gold:brown" style="radial" gradientangle=180]
		a0 [label=<
 <TABLE border="10" cellspacing="10" cellpadding="10" style="rounded" bgcolor="/rdylgn11/1:/rdylgn11/11" gradientangle="315">
	<TR><TD border="3"  bgcolor="/rdylgn11/1:/rdylgn11/2">00</TD>
	<TD border="3"  bgcolor="/rdylgn11/2:/rdylgn11/3">01</TD>
	<TD border="3"  bgcolor="/rdylgn11/3:/rdylgn11/4">02</TD>
	<TD border="3"  bgcolor="/rdylgn11/4:/rdylgn11/5">03</TD>
	</TR>
  
	<TR><TD border="3" bgcolor="/rdylgn11/1:/rdylgn11/6" gradientangle="270">10</TD>
	<TD border="3" rowspan="2"  bgcolor="/rdylgn11/3:/rdylgn11/9" gradientangle="270">11</TD>
	<TD border="3"  bgcolor="/rdylgn11/3:/rdylgn11/8" gradientangle="270">12</TD>
	<TD border="3"  bgcolor="/rdylgn11/4:/rdylgn11/9" gradientangle="270">13</TD>
	</TR>
  
	<TR><TD border="3"  bgcolor="/rdylgn11/6:/rdylgn11/9" gradientangle="270">20</TD>
	<TD border="3" colspan="2"  bgcolor="/rdylgn11/9:/rdylgn11/11">22</TD>
	</TR>
  
	<TR><TD border="3" style="radial" bgcolor="/rdylgn11/1:/rdylgn11/8">30</TD>
	<TD border="3" style="radial" bgcolor="/rdylgn11/1:/rdylgn11/8" gradientangle="45">31</TD>
	<TD border="3" style="radial" bgcolor="/rdylgn11/1:/rdylgn11/8" gradientangle="90" >32</TD>
	<TD border="3" style="radial" bgcolor="/rdylgn11/1:/rdylgn11/8" gradientangle="180">33</TD>
	</TR>
  
</TABLE>>];

}
}
{% enddot %}

## Logical Data Model
{% dot %}
    graph graphnamea {
             a -- b -- c;
             b -- d;
    }
{% enddot %}

## Class diagram
{% dot %}
    graph graphnameb {
             a -- b -- c;
             b -- d;
    }
{% enddot %}

## Mind Map

{% dot %}
    graph graphnamec {
             a -- b -- c;
             b -- d;
    }
{% enddot %}


