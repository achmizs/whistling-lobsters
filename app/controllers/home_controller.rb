class HomeController < ApplicationController
  # for rss feeds, load the user's tag filters if a token is passed
  before_action :find_user_from_rss_token, :only => [ :index, :newest, :saved ]
  before_action { @page = page }
  before_action :require_logged_in_user, :only => [ :upvoted ]

  def four_oh_four
    begin
      @title = "Resource Not Found"
      render :action => "404", :status => 404
    rescue ActionView::MissingTemplate
      render :html => ("<div class=\"box wide\">" <<
        "<div class=\"legend\">404</div>" <<
        "Resource not found" <<
        "</div>").html_safe, :layout => "application"
    end
  end
  
  def downvote_guidelines
  	begin
  		@title = "Downvote Guidelines"
  		render :action => "downvote_guidelines"
  	rescue ActionView::MissingTemplate
  		render :html => ("<div class=\"box wide\">" <<
"<h1>Downvote Guidelines</h1>

<p>
<em>These guidelines are adapted from the <a href='https://github.com/lobsters/lobsters/wiki/DownvoteGuidelines'>downvote guidelines for lobste.rs</a>.</em>
</p>

<h2 id='what-votes-mean-in-general'>What Upvotes and Downvotes Mean</h2>

<p>
<strong>Downvoting</strong> a post or comment means <em>“I don’t think things like this should appear on this site.”</em> <strong>It does not mean “I disagree”.</strong> If you disagree, say so (and say why). If you disagree and it’s not worth your time/effort to say so (much less explain or discuss), then just leave it alone.
</p>
<p>
<strong>Upvoting</strong>, correspondingly, means <em>“this is good; I want to see [more of] things like this on this site”</em>. <strong>It does not mean “I agree”.</strong> If you agree, say so (and say why).
</p>

<p>
<strong>The current list of downvote types are</strong>:
</p>

<ul>
	<li><a href='#off-topic'>Off-topic</a>
	<li><a href='#off-topic'>Incorrect</a>
	<li><a href='#off-topic'>Troll</a>
	<li><a href='#off-topic'>Spam</a>
	<li><a href='#off-topic'>Unnecessarily rude</a>
	<li><a href='#off-topic'>“Inside baseball”</a>
	<li><a href='#off-topic'>Unreasonable</a>
	<li><a href='#off-topic'>Low-quality material</a>
	<li><a href='#off-topic'>Low-effort post/comment</a>
	<li><a href='#off-topic'>Politics done wrong</a>
</ul>

<h2>What the Types Mean</h2>

<h3 id='off-topic'>Off-topic</h3>

<p>
These are used when a comment is totally unrelated to the matter at hand.
</p>
<p>
Applied <em>loosely</em>, this would be downvoting a screed about Trump in a thread on numerical algorithms in C. Applied <em>strictly</em>, this would be downvoting a chat about Linux in a BSD thread without tying it back to the BSD in question.
</p>

<h3 id='incorrect'>Incorrect</h3>

<p>
These are used when a comment is factually or logically incorrect–and in no other cases.
</p>
<p>
Applied loosely, this would be downvoting somebody who says that Paul Graham invented AngularJS. Applied strictly this would be downvoting somebody who says that OpenBSD is the child project of System V (when it’s more of a fork from NetBSD).
</p>
<p>
It is key (<em>key!</em>) that we do not downvote as incorrect matters of <em>opinion</em>.
</p>
<p>
It is also really important that, since we’re using this downvote to show faulty logic, we <strong>comment to explain our downvote</strong>.
</p>

<h3 id='troll'>Troll</h3>

<p>
These are used when a comment is made specifically to get a rise out of other users with no attempt at sharing new information or engaging in honest discussion.
</p>
<p>
Applied <em>loosely</em>, this would be downvoting a comment that insists “The Rust Evangelion Strike Force paid you to say this” or “Only SJWs use Nix” or some variant in every thread without saying anything else. Applied <em>strictly</em>, this would also include comments that tend to kick up strong feelings that people will argue about such as “3 spaces per tab in vim is what makes it better than emacs”.
</p>
<p>
Please be <em>very</em> conservative about deciding that someone is trolling. Again, we have a small community here, membership is invite-only, and it just is not likely that someone will post or comment simply to annoy people.
</p>

<h3 id='spam'>Spam</h3>

<p>
These downvotes are used whenever encountering obvious advertising/news/marketing shit.
</p>
<p>
Posting spam is a quick way to get banned. (If you see spam, please alert a <a href='/u?moderators=1'>moderator</a>.)
</p>

<h3 id='unnecessarily-rude'>Unnecessarily rude</h3>

<p>
It’s not hard to identify rudeness, but please don’t use this category for simple curtness, matter-of-factness, sarcasm, opinionatedness, or other small deviations from flawless politeness, as long as the comment is on-topic and otherwise appropriate. However, we don’t tolerate vulgarity, crudeness, and aggressive confrontationalism between members.
</p>

<h3 id='inside-baseball'>“Inside baseball”</h3>

<p>
(<a href='https://en.wikipedia.org/wiki/Inside_baseball_%28metaphor%29'>Reference</a> for non-Americans who’re unfamiliar with the term.)
</p>
<p>
This is for stuff that is exceedingly focused on the doings and goings-on of some particular tiny subculture; or is ingroup-jargon-filled to the point of incomprehensibility to anyone outside a small, niche group; or otherwise not of any conceivable interest to any WL member who isn’t deeply involved in the group in question.
</p>

<h3 id='unreasonable'>Unreasonable</h3>

<p>
Sometimes (though hopefully very rarely, here), a commenter may write/converse in a way that’s either totally nonsensical, or utterly impervious to reason, or riddled with egregious failures of logic or basic sense. “Unreasonable” downvotes are for such situations.
</p>
<p>
<strong>Be careful with this category!</strong> This is <em>not</em> simply for people who <em>disagree</em> with you, even if you think their views are dumb, or if they’re disagreeing quite <em>vehemently</em>, or if you think you’ve won the argument but your interlocutor is of a different opinion. If you abuse this category of downvote, people (and the mods) <em>will</em> notice!
</p>

<h3 id='low-quality'>Low-quality material</h3>

<p>
Stuff that is intellectually sloppy, sensationalistic, clickbaity, more-heat-than-light, speculative while pretending not to be, etc. (This applies mostly to posts, but can apply to comments as well.) If you downvote a <em>comment</em> for low quality, <strong>you must comment to say why</strong>.
</p>

<h3 id='low-effort'>Low-effort post/comment</h3>

<p>
This is primarily for garbage/low effort comments that aren’t malicious enough to be flagged troll. It includes things like one-word posts, unpunctuated throw-away one-liners, dumb jokes, etc.
</p>

<p>
<strong>Note:</strong> “Me too”, “I agree”, and similar comments do <em>not</em> fall into this category! We do not discourage comments like that, as a general rule; to the contrary, we <em>want</em> to hear from people who agree with something that's said or posted, rather than only hearing from people who disagree. (Of course, if a user <em>only</em> ever posts stuff like this, and never says or contributes anything more interesting, then we would encourage that user to participate in a more substantial manner.)
</p>

<h3 id='politics'done-wrong'>Politics done wrong</h3>

<p>
Explained in <a href='https://lobsters.obormot.net/s/xb4kt4/what_should_this_site_be_about#c_ieixsv'>this comment</a>.
</p>
<p>
(<em>Note:</em> This category is <strong>absolute not</strong> for “politics I disagree with”. Please read and understand the linked explanation before using this category of downvote!)
</p>
" <<
  			"</div>").html_safe, :layout => "application"
  	end
  end

  def about
    begin
      @title = "About"
      render :action => "about"
    rescue ActionView::MissingTemplate
      render :html => ("<div class=\"box wide about-page-text\">" <<
"<h1>About Whistling Lobsters</h1>

<p><em>The short version:</em></p>

<p>
<strong>Whistling Lobsters is a community focused on high-quality link aggregation and discussion, with a broad range of interests.</strong>
</p>

<hr />

<p><em>The long version:</em></p>

<ul class='table-of-contents'>
	<li><a href='#what-is-this'>What Is This?</a>
	<li><a href='#who-are-we'>Who Are We?</a>
	<li><a href='#what-are-we-doing-here'>What Are We Doing Here?</a>
	<li class='subhead'><a href='#features-and-goals'>Features & Goals</a>
	<ul>
		<li><a href='#tagging'>Tagging</a>
		<li><a href='#invitation-tree'>Invitation Tree</a>
		<li><a href='#downvote-explanations'>Downvote Explanations</a>
		<li><a href='#transparency-policy'>Transparency Policy</a>
		<li><a href='#other-technical-features'>Other Technical Features</a>
	</ul>
	<li><a href='#additional-info'>Additional Info</a>
</ul>

<h2 id='what-is-this'>What Is This?</h1>

<p>
Whistling Lobsters aims to stand at the intersection of <strong>interesting</strong>, <strong>useful</strong>, and <strong>excellent</strong>.
</p>
<p>
<strong>Interesting:</strong> We want to see things that inspire us, that pique our curiosity, that make us think (<em>really</em> make us think, and not just <em>feel like</em> we’re thinking); things that expand our horizons and things that broaden and deepen our existing knowledge and understanding. Whoever you are, if you’re a member of the site, we want to see what <em>you</em> find interesting; we invited you because we want your perspective, your focus, added to those of the rest of us.
</p>
<p>
<strong>Useful:</strong> We don’t want “insight porn”—things that make us feel smart and insightful when we read them, that give the transient rush of faux-enlightenment, but leave us none the more informed, nor more capable, nor wiser. We <em>do</em> want things that give us useful skills and useful tools—including (though by no means <em>limited to</em>) the mental tools to better understand particular parts or aspects of the world. For every link or story posted, we want to hear about <em>why</em> you find it interesting! What did <em>you</em> get out of this? Is there a concrete, actionable takeaway—some immediate application, some concrete improvement in your understanding of a specific topic? Or, conversely, did this thing inform your world-view, in some hard-to-articulate way? In either case, tell us!
</p>
<p>
<strong>Excellent:</strong> We don’t want disposable schlock. Not every link and post can be timeless; but that goal, not <em>achievable</em> entirely or even mostly, nonetheless can be <em>approached</em> more closely than most forums of today. There are many heuristics you can use: post things <em>you’d</em> want to bookmark; post research, not clickbait mainstream-journalism pieces about research; avoid the heated, partisan politics of the hour. It can be hard to know, sometimes, how good something is. We can tackle <em>that</em> task together; get us started, by telling us what <em>you</em> know about the thing you’re posting! Are you an expert in the field, or is the topic a special interest of yours? Perhaps you knew nothing of the topic before coming across this article, but were inspired to research the matter? Either way, tell us, and give us your take! What do <em>you</em> know about whether what you posted is worthwhile, and what do you <em>think</em>?
</p>
<p>
The best material is all three of <em>interesting</em>, <em>useful</em>, and <em>excellent</em>. That is not an ironclad requirement, however; while it’s the intersection of qualities that we aim for, it’s ok to drift “off-target”, if a deficit of one of the three is made up for by the others. Is there something that you think is excellent and useful, but perhaps slightly niche of interest? Post it! An essay that’s breathtakingly fascinating and masterfully written, but perhaps not very obviously useful? Post it! An article that’s useful and interesting, but perhaps flawed in some ways? Post it—we’ll discuss it, and evaluate its quality, together. Drift is ok—though try not to drift too far (but don’t overthink it, either; go with your instincts; we—the other commenters and moderators—will let you know, if you go astray).
</p>
<p>
You may have noticed a repeated theme, in the paragraphs above: <strong>we want to hear what you think</strong>. Whistling Lobsters isn’t just another “aggregator”, gushing forth a stream of hyperlinks without context or comment; in contrast to some other places on the internet, when you post a link here, we encourage you to post your own thoughts with it. Tell us why you think what you’ve posted is interesting; tell us why you find it useful; tell us what you know of how good it is. As in the previous paragraph, it’s not a <em>requirement</em> that you do this for each link you submit; in some cases, it may be <em>obvious</em> what makes a linked page or site excellent and interesting and useful—some things need little in the way of explanation (such as pages or websites which are simply useful resources). But be <em>ready</em> to tell us what you think about the things you post, should other commenters inquire!
</p>
<p>
If you find that you can’t say why something is interesting, <em>or</em> why it’s useful, <em>or</em> how it’s excellent—if, indeed, you have nothing much to say about what you’re posting—consider <em>not</em> posting it. Conversely, if you <em>do</em> have something to say, even if it’s <em>about the fact that you find something interesting/useful/excellent but can’t easily explain why</em>, then by all means post it—it is the difficult discussions, where what there is to say, is hard to put into words, that are among the most interesting.
</p>

<h2 id='who-are-we'>Who Are We?</h1>

<p>
How can you know whether you’ll ‘fit in’, around here?
</p>
<p>
Defining a group is hard. A group may be defined by the set of its members; but people may join, or leave. A group may be defined by a statement of purpose, or by a set of principles; but its members may act otherwise, or they may choose another purpose, or new principles.
</p>
<p>
So, with full acknowledgment of the difficulty of the task:
</p>
<p>
We are people with a variety of interests—some narrow and intense, others broad and eclectic—who want to <strong>understand the world better</strong>. Our focus is <em>not</em> limited to “rationality”, or to technology, or to “STEM”, or to science (or “science”); our focus is not limited by <em>any</em> attempt to <em>circumscribe</em> who we are and what interests us—though we reserve the right to decide who and what we are <em>not</em>.
</p>
<p>
We are, inevitably, “a certain sort of people”—if only because it takes a certain sort of person to write a manifesto like this, or to read it, or participate at all in a web forum where interesting, useful, and excellent things are discussed—much less one where such discussions come with high intellectual standards, and are expected to be both <em>reasoned</em> and <em>respectful</em>. We need not nail down our identity much beyond that. (The invite-only nature of WL membership means that, if anything, we’ll have to work hard indeed to make our membership encompass more than “the usual sort” of ideas and viewpoints—a goal that we should, and will, strive for.)
</p>
<p>
But, for all that—will you fit in? That’s easy:
</p>
<p>
(a) Do you find the material already on the site interesting, useful, or both? (b) Do you think you have anything to add, anything to say, anything to share with us, on the topics already represented here, or on other topics that you think might interest us? Do you, in other words, <em>want</em> to participate?
</p>
<p>
If, to both of these, you answer ‘yes’; and if you’ve been invited by an existing member; then it is almost certain that you’ll get along here just fine.
</p>
<p>
(What if you’re already a member, and want to know whether to invite a friend? Ask them the two questions above! Will they be reasoned and respectful in their participation? Do you think they have interesting things to say, useful ideas to add to our discussions, knowledge / expertise / background / experience to add to ours and enrich us thereby? Then invite them! Your judgment about such things is part of why we invited <em>you</em>.)
</p>

<h2 id='what-are-we-doing-here'>What Are We Doing Here?</h1>

<p>
We’re posting links to interesting, useful, and excellent things on the internet, and discussing those things.[1]
</p>
<p>
What <em>aren’t</em> we doing here?
</p>
<p>
There are rules, certainly. Besides what's covered on this page, the <a href='/downvote_guidelines'>Downvote Guidelines</a> describe most of what we expect from you, when posting here; much of the rest boils down to “discuss in a reasoned manner; be respectful”.
</p>
<p>
Remember, though, that above all we try to be sensible people with good judgment—not automatons. The rules are guidelines, designed to help each of us understand what we all expect from each other, and to help us create something of lasting value. We’ll break the letter of the rules to protect their spirit. As described in <a href='http://nostalgebraist.tumblr.com/post/160883443284/this-has-occurred-to-me-independently-several'>this post</a>, remember that you’re dealing with people, not with the rules; the judgment of the moderators is final. That said, the rules are there for a reason—and that reason is that we endorse them, and think that they are good and proper rules, which express how we think this site should work.
</p>
<p>
[1] Sometimes there are top-level posts that aren’t links to anything; those almost always have to do with “meta” issues, i.e. discussing the site itself, and matters relating to it. WL is not a blog; however, feel free to post <em>links</em> to your posts on your own blog elsewhere, if you’d like to discuss them here.</p>

<hr />

<h2 id='features-and-goals'>Features & Goals</h1>

<ul class='table-of-contents'>
	<li><a href='#tagging'>Tagging</a>
	<ul>
		<li><a href='#creating-new-tags'>Creating new tags</a>
	</ul>
	<li><a href='#invitation-tree'>Invitation Tree</a>
	<li><a href='#downvote-explanations'>Downvote Explanations</a>
	<li><a href='#transparency-policy'>Transparency Policy</a>
	<li><a href='#other-technical-features'>Other Technical Features</a>
</ul>

<p>
Whistling Lobsters runs on a fork of the code used by <a href='https://lobste.rs'>Lobsters</a>, so WL has many of the same features, plus a growing list of new features that we've added. (Note that even in the case of features that WL shares with the original Lobsters, some of those features <em>work differently</em> here; also, some of those features are <em>used differently</em> here. See each feature's description, below, for details.)
</p>

<h3 id='tagging'>Tagging</h2>

<p>
When links/stories are submitted, they must be tagged by the submitter from a list of predefined <a href='/tags'>tags</a>. Users can choose to <a href='/filters'>filter</a> out all submissions with particular tags, but rather than use rigidly segmented sub-forums that users must each subscribe to, all users see all stories by default. There are several reasons for this:
</p>
<ul>
	<li>
		<p>
		It helps to focus topics of interest and conversation, by only allowing a predefined list of tags. These tags represent the current scope of interests of the site's members, and the preferences of the community about what sorts of things we do and do not want to see here.
		</p>
		<p>
		If you have something you'd like to post, but it doesn't fit into any of the current tags, it's possible that we simply haven't ever had anyone who had enough interest in, and knowledge of, the topic to post about it; in that case, we might welcome your contributions on that topic, and would be happy to add the relevant tag(s) (see <a href='#creating-new-tags'>Creating new tags</a>, below). It's also possible that we've decided that we'd prefer not to see content of that sort on WL. (If you suspect that might be the case, feel free to contact one of our <a href='/u?moderators=1'>moderators</a> to ask about it.)
		</p>
	<li>
		<p>
		It keeps stories organized and more easily searchable.
		</p>
	<li>
		<p>
		It promotes discussion. On a site with separate forums, members might visit only the forum that concerns their specific, narrow interests, even though they may have useful and interesting things to say on other topics (indeed, expanding the range of perspectives from which we see commentary on topics of interest is one of the aims of Whistling Lobsters). This way, everyone sees everything by default, but each visitor to the site can still easily narrow down what he sees by clicking on a tag (this is also a much more flexible way of narrowing down the discussion list than a fixed set of topic-specific forums).
		</p>
	<li>
		<p>
		It keeps the conversation centralized. Often stories contain discussion about more than one topic, yet on other sites they are confined to a single category/forum, limiting the exposure. The link could be submitted to more than one forum, but then each conversation would remain separate and users would rarely interact with users from other forums. On this site, the story would simply be tagged with multiple tags and all users would see all discussion about the story in a single location.
		</p>
</ul>

<h4 id='creating-new-tags'>Creating new tags</h4>

<p>
Creating new tags (and retiring old tags) is done by the community by submitting, discussing, and voting on <a href='/t/meta' class='tag'>meta</a>-tagged requests about them.
</p>

<h3 id='invitation-tree'>Invitation Tree</h3>

<p>
Invitations are used as a mechanism for spam-control and to encourage users to “be nice”. New users must be invited by a current user, though there is no vetting process and invitations are not intended to promote exclusivity. The best way to receive an invitation is to talk to someone you recognize from the site. Invitations are unlimited unless scaling problems temporarily prevent new accounts. If spammers are invited to the site and banned, the user that invited them may also be banned, going up the chain of invitations as needed.
</p>
<p>
The full <a href='/u'>user tree</a> is made public and each user's profile shows who invited them. This provides some degree of accountability and can act as a tool to help identify voting rings.
</p>

<h3 id='downvote-explanations'>Downvote Explanations</h3>

<p>
Often on other sites, a user would have his or her comment downvoted without explanation and then edit their comment to ask why they were downvoted. On this site, voters must choose a reason before downvoting comments and those votes are tallied and shown to the original commenter. (See the <a href='/downvote_guidelines'>Downvote Guidelines</a> for what we consider to be valid reasons for downvoting a comment, and other information about how downvoting works.)
</p>
<p>
For submitted stories, downvoting is done through flagging (also requiring a valid reason) and these flag summaries are shown to all users.
</p>

<h3 id='transparency-policy'>Transparency Policy</h3>

<p>
All <a href='/moderations'>moderator actions</a> on this site are visible to everyone and the identities of those moderators are <a href=/u?moderators=1'>made public</a>. While the individual actions of a moderator may cause debate, there should be no question about which moderator it was or whether they had an ulterior motive for those actions.
</p>
<p>
All user voting and story ranking on this site uses a universal algorithm and does not artificially penalize or prioritize users or domains. Per-tag <a href='/filters'>hotness modifiers</a> do affect all stories with those tags, but these modifiers are made public (currently, Whistling Lobsters has no hotness modifiers for any tags). If certain domains have to be banned from being submitted due to spam, the list will be made publicly available.
</p>
<p>
If users are disruptive enough to warrant banning, they will be banned absolutely, given notice of their banning, and their disabled user profile will indicate which moderator banned them and why. There will be no hidden, antisocial “shadow banning” or “hellbanning” of users.
</p>
<p>
The <a href='https://github.com/achmizs/whistling-lobsters'>source code to this site</a> is made available under a 3-clause BSD license for viewing, auditing, forking, or contributing to. <span class='inactive-feature'>Public stats are available for site requests, comments submitted, stories submitted, total users, and users created per day.</span>
</p>

<h3 id='other-technical-features'>Other Technical Features</h3>

<ul>
<li>
	<p>
	<span class='inactive-feature'><a href='https://lobste.rs/s/jg3eet'><strong>Mailing list mode</strong></a> can be enabled per-user to receive all new stories (including their plain-text content as fetched and extracted by <a href='diffbot.com' rel=nofollow>Diffbot</a>) and user comments as e-mails, mirroring discussion threads offline. This makes it easy and efficient to read new stories as well as keep track of new comments on old threads or stories, just like technical mailing lists or Usenet of yore. Each user is assigned a private mailing list address at this domain which allows them to reply to stories or comments directly in their e-mail client. These e-mails are then converted and submitted to the website as comments, just as if the comment was posted through a web browser.</span>
	</p>
<li>
	<p>
	<strong>Private messaging</strong> enables users to communicate privately without having to publicly disclose an e-mail address, and users can receive e-mail <span class='inactive-feature'>and <a href='pushover.net' rel=nofollow>Pushover</a> notifications</span> of new private messages.
	</p>
<li>
	<p>
	<strong>Responsive design</strong> enhances functionality on smaller screens such as phones and tablets without having to use a separate URL, 3rd party (often read-only) websites, or proprietary mobile applications.
	</p>
<li>
	<p>
	<a href='/search'><strong>Integrated search engine</strong></a> covers all submitted stories and comments, including full-text caches of all submitted story contents. Searching for a keyword will often bring up relevant stories that don't even mention that keyword in the URL or title.
	</p>
<li>
	<p>
	<a href='https://lobste.rs/s/cqq0kg/story_merging'><strong>Story merging</strong></a> combats the problem of multiple stories at different URLs being submitted in a short timeframe about the same news subject. Rather than have multiple stories on the front page with fragmented discussions, all similar stories can be merged into one. An example of a story having been merged into a previous one, combining all comments on one page.
	</p>
<li>
	<p>
	<strong>Fuzzy-matching of submitted story URLs</strong> to avoid duplicate submissions of similar URLs that differ only in <code>http</code> vs. <code>https</code>, trailing slashes, useless analytics parameters, etc. When using the <a href='javascript:{window.open(%22https://lobsters.obormot.net/stories/new?url=%22+encodeURIComponent(document.location)+%22&title=%22+encodeURIComponent(document.title));%20void(0);}'>story submission bookmarklet</a>, story URLs are automatically converted to use the page's canonical URL (if available) to present the best URL to represent the story, as defined by the story's author or publisher.
	</p>
<li>
	<p>
	<span class='inactive-feature'><strong>User-suggested titles and tags</strong> can be automatically applied to a story when a quorum of users agrees on a new title (such as removing a site's name, or appending the story's year of publication) or set of tags, without any moderator action required.</span>
	</p>
<li>
	<p>
	<a href='/hats'><strong>Hats</strong></a> are a more formal process of allowing users to post comments while “wearing <em>such and such</em> hat” to give their words more authority (such as an employee speaking for the company, or an open source developer speaking for the project).
	</p>
<li>
	<p>
	<a href='/rss'><strong>Per-tag and site-wide RSS feeds</strong></a> are available to the public and logged-in users have private RSS feeds that filter out each user's <a href='/filters'>filtered tags</a>.
	</p>
<li>
	<p>
	<span class='inactive-feature'>Stickers are available to show your support for the site.</span>
	</p>
<li>
	<p>
	<strong>Click-through counts</strong> show you how many people clicked on the link you posted, allowing you to judge whether people are viewing the material you’re submitting.
	</p>
</ul>

<hr />

<h2 id='additional-info'>Additional Info</h2>

<ul>
<li>the <a href='/downvote_guidelines'><strong>Downvote Guidelines</strong></a>
<li>the list of available <a href='/tags'><strong>tags</strong></a> (plus <a href='/filters'>more info on the tags</a>)
<li>the <a href='/u'><strong>user tree</strong></a>
</ul>
" <<
        "</div>").html_safe, :layout => "application"
    end
  end

  def chat
    begin
      @title = "Chat"
      render :action => "chat"
    rescue ActionView::MissingTemplate
      if @user
		  render :html => ("<div class=\"box wide\">" <<
			"<div class=\"legend\">Chat</div>" <<
			"<iframe id='web-chat-frame' src='https://webchat.freenode.net?channels=%23oborlobsters'></iframe>" <<
			"</div>").html_safe, :layout => "application"
      else
		  render :html => ("<div class=\"box wide\">" <<
			"<div class=\"legend\">Chat</div>" <<
			"<p>Only logged-in users can chat.</p>" <<
			"</div>").html_safe, :layout => "application"
      end
    end
  end

  def privacy
    begin
      @title = "Privacy"
      render :action => "privacy"
    rescue ActionView::MissingTemplate
      render :html => "<div class=\"box wide\">" <<
        "You apparently have no privacy." <<
        "</div>", :layout => "application"
    end
  end

  def hidden
    @stories, @show_more = get_from_cache(hidden: true) {
      paginate stories.hidden
    }

    @heading = @title = "Hidden Stories"
    @cur_url = "/hidden"

    render :action => "index"
  end

  def index
    @stories, @show_more = get_from_cache(hottest: true) {
      paginate stories.hottest
    }

    @rss_link ||= { :title => "RSS 2.0",
      :href => "/rss#{@user ? "?token=#{@user.rss_token}" : ""}" }
    @comments_rss_link ||= { :title => "Comments - RSS 2.0",
      :href => "/comments.rss#{@user ? "?token=#{@user.rss_token}" : ""}" }

    @heading = @title = ""
    @cur_url = "/"

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss {
        if @user
          @title = "Private feed for #{@user.username}"
          render :action => "rss", :layout => false
        else
          content = Rails.cache.fetch("rss", :expires_in => (60 * 2)) {
            render_to_string :action => "rss", :layout => false
          }
          render :plain => content, :layout => false
        end
      }
      format.json { render :json => @stories }
    end
  end

  def newest
    @stories, @show_more = get_from_cache(newest: true) {
      paginate stories.newest
    }

    @heading = @title = "Newest Stories"
    @cur_url = "/newest"

    @rss_link = { :title => "RSS 2.0 - Newest Items",
      :href => "/newest.rss#{@user ? "?token=#{@user.rss_token}" : ""}" }

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss {
        if @user && params[:token].present?
          @title += " - Private feed for #{@user.username}"
        end

        render :action => "rss", :layout => false
      }
      format.json { render :json => @stories }
    end
  end

  def newest_by_user
    by_user = User.where(:username => params[:user]).first!

    @stories, @show_more = get_from_cache(by_user: by_user) {
      paginate stories.newest_by_user(by_user)
    }

    @heading = @title = "Newest Stories by #{by_user.username}"
    @cur_url = "/newest/#{by_user.username}"

    @newest = true
    @for_user = by_user.username

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss {
        render :action => "rss", :layout => false
      }
      format.json { render :json => @stories }
    end
  end

  def recent
    @stories, @show_more = get_from_cache(recent: true) {
      scope = if page == 1
        stories.recent
      else
        stories.newest
      end
      paginate scope
    }

    @heading = @title = "Recent Stories"
    @cur_url = "/recent"

    # our content changes every page load, so point at /newest.rss to be stable
    @rss_link = { :title => "RSS 2.0 - Newest Items",
      :href => "/newest.rss#{@user ? "?token=#{@user.rss_token}" : ""}" }

    render :action => "index"
  end

  def saved
    @stories, @show_more = get_from_cache(hidden: true) {
      paginate stories.saved
    }

    @rss_link ||= { :title => "RSS 2.0",
      :href => "/saved.rss#{@user ? "?token=#{@user.rss_token}" : ""}" }

    @heading = @title = "Saved Stories"
    @cur_url = "/saved"

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss {
        if @user
          @title = "Private feed of saved stories for #{@user.username}"
          render :action => "rss", :layout => false
        else
          render :action => "rss", :layout => false
        end
      }
      format.json { render :json => @stories }
    end
  end

  def tagged
    @tag = Tag.where(:tag => params[:tag]).first!

    @stories, @show_more = get_from_cache(tag: @tag) {
      paginate stories.tagged(@tag)
    }

    @heading = @title = @tag.description.blank?? @tag.tag : @tag.description
    @cur_url = tag_url(@tag.tag)

    @rss_link = { :title => "RSS 2.0 - Tagged #{@tag.tag} (#{@tag.description})",
      :href => "/t/#{@tag.tag}.rss" }

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss { render :action => "rss", :layout => false }
      format.json { render :json => @stories }
    end
  end

  TOP_INTVS = { "d" => "Day", "w" => "Week", "m" => "Month", "y" => "Year" }
  def top
    @cur_url = "/top"
    length = { :dur => 1, :intv => "Week" }

    if m = params[:length].to_s.match(/\A(\d+)([#{TOP_INTVS.keys.join}])\z/)
      length[:dur] = m[1].to_i
      length[:intv] = TOP_INTVS[m[2]]

      @cur_url << "/#{params[:length]}"
    end

    @stories, @show_more = get_from_cache(top: true, length: length) {
      paginate stories.top(length)
    }

    if length[:dur] > 1
      @heading = @title = "Top Stories of the Past #{length[:dur]} " <<
        length[:intv] << "s"
    else
      @heading = @title = "Top Stories of the Past " << length[:intv]
    end

    render :action => "index"
  end

  def upvoted
    @stories, @show_more = get_from_cache(upvoted: true, user: @user) {
      paginate @user.upvoted_stories.order('votes.id DESC')
    }

    @heading = @title = "Your Upvoted Stories"
    @cur_url = "/upvoted"

    @rss_link = { :title => "RSS 2.0 - Your Upvoted Stories",
      :href => "/upvoted.rss#{(@user ? "?token=#{@user.rss_token}" : "")}" }

    respond_to do |format|
      format.html { render :action => "index" }
      format.rss {
        if @user && params[:token].present?
          @title += " - Private feed for #{@user.username}"
        end

        render :action => "rss", :layout => false
      }
      format.json { render :json => @stories }
    end
  end

private
  def filtered_tag_ids
    if @user
      @user.tag_filters.map{|tf| tf.tag_id }
    else
      tags_filtered_by_cookie.map{|t| t.id }
    end
  end

  def stories
    StoryRepository.new(@user, exclude_tags: filtered_tag_ids)
  end

  def page
    p = params[:page].to_i
    if p == 0
      p = 1
    elsif p < 0 || p > (2 ** 32)
      raise ActionController::RoutingError.new("page out of bounds")
    end
    p
  end

  def paginate(scope)
    StoriesPaginator.new(scope, page, @user).get
  end

  def get_from_cache(opts={}, &block)
    if Rails.env.development? || @user || tags_filtered_by_cookie.any?
      yield
    else
      key = opts.merge(page: page).sort.map{|k,v| "#{k}=#{v.to_param}"
        }.join(" ")
      begin
        Rails.cache.fetch("stories #{key}", :expires_in => 45, &block)
      rescue Errno::ENOENT => e
        Rails.logger.error "error fetching stories #{key}: #{e}"
        yield
      end
    end
  end
end
