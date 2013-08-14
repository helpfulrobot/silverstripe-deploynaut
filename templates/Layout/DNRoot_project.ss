<h3>Environments</h3>
<table class="table-striped table table-bordered">
	<thead>
		<tr>
			<th>Environment</th>
			<th>URL</th>
			<th>Build currently deployed</th>
			<th>Can you deploy?</th>
			<th>More info</th>
		</tr>
	</thead>
	<tbody>
	<% if DNEnvironmentList %>
	<% loop DNEnvironmentList %>
		<tr>
			<td><% if CanDeploy %><a href="$Link">$Name</a><% else %>$Name<% end_if %></td>
			<td><a href="$URL">$URL</a></td>
			<td>$CurrentBuild</td>
			<td>
			<% if CanDeploy %><span class="good">Yes</span>
			<% else_if DeployersList %>
			No, ask $DeployersList
			<% else %>
			<span class="bad">Deployment disabled</span>
			<% end_if %>
			</td>
			<td>
				<% if HasMetrics %>
				<a a href="$Link/metrics">Metrics</a>
				<% end_if %>
			</td>
		</tr>
	<% end_loop %>
	<% else %>
		<tr>
			<td colspan="3">No environments available yet!</td>
		</tr>
	<% end_if %>
	</tbody>
</table>

<h3>Repository</h3>
<% if getRepositoryURL %>
	<pre>$getRepositoryURL</pre>
<% end_if %>
<% if repoExists %>
	<a href="{$Link}/update" class="btn update-repository">Fetch latest changes</a>
<% else %>
	<p>Getting latest changes from your repository. You may refresh this page at will.</p>
<% end_if %>

<% if getPublicKey %>
	<h3>Public key</h3>
	<pre>$getPublicKey</pre>
<% end_if %>

<% loop DNBranchList %>
<% if DNBuildList.Count %>
<div class="project-branch$IsOpenByDefault">
<h3>
	<span class="open-icon">-</span><span class="closed-icon">+</span>
	$Name
	<small>last updated: $LastUpdated.Nice ($LastUpdated.Ago)</small>
</h3>
<div class="project-branch-content">
<p>Legend: 
	<span class="label label-info">release tag</span>
	<span class="label">other branch containing this</span>
</p>
<table class="table-striped table table-bordered">
	<thead>
		<tr>
			<th>Release</th>
			<th>Message</th>
			<th>Currently on</th>
			<th>Date created</th>
			<% if Top.ReleaseSteps %>
			<th>Release Process</th>
			<% end_if %>
		</tr>
	</thead>
	<tbody>
	<% loop DNBuildList %>
		<tr>
			<td
				>$Name
				<% loop $References %>
				<span class="label <% if $Type = Tag %>label-info<% end_if %>" title="$Type">$Name</span>
				<% end_loop %>
			</td>
			<td title="$SubjectMessage $BodyMessage">$SubjectMessage</td>
			<td>
				<% loop CurrentlyDeployedTo %>
				<a href="{$Link}">$Name</a><% if not $Last %>,<% end_if %>
				<% end_loop %>
			</td>
			<td class="nowrap">$Created.Nice ($Created.Ago)</td>
			<% if ReleaseSteps %>
			<td class="release-process nowrap">
				<% loop ReleaseSteps %>
				<% if $Status = "success" %>
				<a href="$Link" class="label label-success $FirstLast">$Name</a>
				<% else_if $Status = "failure" %>
				<a href="$Link" class="label label-important $FirstLast">$Name</a>
				<% else %>
				<a href="$Link" class="label $FirstLast">$Name</a>
				<% end_if %>
				<% end_loop %>
			</td>
			<% end_if %>
		</tr>
	<% end_loop %>
	</tbody>
</table>
</div>
</div>
<% end_if %>
<% end_loop %>